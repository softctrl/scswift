//
//  SCContactUtils.swift
//  SCSwift
//
//  Created by Timoshenko on 15/05/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation
import UIKit
import Contacts

/// <#Description#>
public class SCContactUtils {
    
    /// <#Description#>
    private var dlg : SCDialogUtils? = nil
    
    /// <#Description#>
    ///
    /// - Parameter view: <#view description#>
    public init(_ view : UIViewController) {
        self.dlg = SCDialogUtils(view: view)
    }

    /// <#Description#>
    ///
    /// - Parameter handler: <#handler description#>
    public func validatePermission(handler: @escaping (_ granted: Bool) -> Void) {
        
        // Get authorization
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        // Find out what access level we have currently
        switch authorizationStatus {
        case .authorized:
            handler(true)
        case .denied, .notDetermined:
            CNContactStore().requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
                if access {
                    handler(access)
                }
                else {
                    if authorizationStatus == CNAuthorizationStatus.denied {
                        DispatchQueue.main.async(execute: { () -> Void in
                            let message = "\(accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
                            self.dlg?.showDialogMessage(title: "Permission for Contact", message: message)
                        })
                    }
                }
            })
            
        default:
            handler(false)
        }

    }
    
    /// <#Description#>
    ///
    /// - Parameter phoneNumber: <#phoneNumber description#>
    public func searchForContactUsingPhoneNumber(phoneNumber: String) {
        
        DispatchQueue.global(/*Int(QOS_CLASS_USER_INTERACTIVE.rawValue), 0*/).async(execute: { () -> Void in
            self.validatePermission { (accessGranted) -> Void in
                if accessGranted {
                    let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactImageDataKey, CNContactPhoneNumbersKey]
                    var contacts = [CNContact]()
                    var message: String!
                    
                    let contactsStore = CNContactStore()
                    do {
                        try contactsStore.enumerateContacts(with: CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])) {
                            (contact, cursor) -> Void in
                            if (!contact.phoneNumbers.isEmpty) {
                                
                                
                                let phoneNumberToCompareAgainst = phoneNumber.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
                                for phoneNumber in contact.phoneNumbers {
                                    let phoneNumberStruct = phoneNumber.value
                                    let phoneNumberString = phoneNumberStruct.stringValue
                                    let phoneNumberToCompare = phoneNumberString.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
                                    if phoneNumberToCompare == phoneNumberToCompareAgainst {
                                        contacts.append(contact)
                                    }
                                }
                            }
                        }
                        
                        if contacts.count == 0 {
                            message = "No contacts were found matching the given phone number."
                        }
                    }
                    catch {
                        message = "Unable to fetch contacts."
                    }
                    
                    if message != nil {
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.dlg?.showDialogMessage(message: message)
                        })
                    }
                    else {
                        // Success
                        DispatchQueue.main.async(execute: { () -> Void in
                            // Do someting with the contacts in the main queue, for example
                            /*
                             self.delegate.didFetchContacts(contacts) <= which extracts the required info and puts it in a tableview
                             */
                            print(contacts) // Will print all contact info for each contact (multiple line is, for example, there are multiple phone numbers or email addresses)
                            let contact = contacts[0] // For just the first contact (if two contacts had the same phone number)
                            print(contact.givenName) // Print the "first" name
                            print(contact.familyName) // Print the "last" name
                            if contact.isKeyAvailable(CNContactImageDataKey) {
                                if let contactImageData = contact.imageData {
                                    print(UIImage(data: contactImageData) ?? "") // Print the image set on the contact
                                }
                            } else {
                                // No Image available
                                
                            }
                        })
                    }
                }
            }
        })
    }

}
