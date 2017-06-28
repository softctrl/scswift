//
//  SCDialogUtils.swift
//  QApp
//
//  Created by Timoshenko on 29/03/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import PopupDialog

public final class SCDialogUtils: NSObject {
    
    /// Constants.
    public final class Constants {
        public static var TITLE_DEFAULT = "WARNING!"
        public static var BUTTON_OK = "OK"
    }
    
    private var view : UIViewController
    
    
    /// Default constructor.
    ///
    /// - Parameter view: A view ontroller.
    public init(view : UIViewController) {

        self.view = view
        super.init()

    }
    
    /// Show a dialog message.
    ///
    /// - Parameters:
    ///   - title: Title for the dialog.
    ///   - message: Message to be presented.
    ///   - image: Image if you want.
    public func showDialogMessage(title: String = Constants.TITLE_DEFAULT, message : String!, image: UIImage? = nil, action : @escaping () -> Swift.Void = {}) {
        
        OperationQueue.main.addOperation {
            let popup = PopupDialog(title: title, message: message, image: image)
            let buttonOk = CancelButton(title: Constants.BUTTON_OK, action: {
                OperationQueue.main.addOperation {
                    action()
                }
            })
            popup.addButtons([buttonOk])
            self.view.present(popup, animated: true, completion: nil)
        }
        
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - message: <#message description#>
    ///   - actions: <#actions description#>
    ///   - cancelHandler: <#cancelHandler description#>
    ///   - completion: <#completion description#>
    public func showActionSheet(message: String!, actions : [UIAlertAction]!, cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil, completion: (() -> Swift.Void)? = nil) {
        
        let optionMenu = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        
//        // 2
//        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: {
//            (alert: UIAlertAction!) -> Void in
//            print("File Deleted\n")
//        })
//        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
//            (alert: UIAlertAction!) -> Void in
//            print("File Saved\n")
//        })
//        
//        //
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
//            (alert: UIAlertAction!) -> Void in
//            print("Cancelled\n")
//        })
        
        // 4
        for action in actions {
            optionMenu.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled\n")
            if cancelHandler != nil {
                cancelHandler!(alert)
            }
        })
        optionMenu.addAction(cancelAction)
        
        // 5
        self.view.present(optionMenu, animated: true, completion: completion)

    }

}
