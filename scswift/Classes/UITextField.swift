//
//  NSRange.swift
//  SCSwift
//
//  Created by Timoshenko on 18/05/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
// Original from http://swiftexample.info/snippet/uitextfieldmaskpatternswift_dedeexe_swift
// Updatet for Swift 3.1
//
import UIKit

// MARK: - <#Description#>
extension UITextField {
    
    /// <#Description#>
    private struct FKFieldPatterns {
        static var pattern          = "pattern"
        static var replacementChar  = "replacementChar"
        static var allowNumbers     = "allowNumbers"
        static var allowText        = "allowText"
    }
    
    /// <#Description#>
    private var pattern : String {

        if let result = objc_getAssociatedObject(self, &FKFieldPatterns.pattern) as? String {
            return result
        }
        return ""

    }
    
    /// <#Description#>
    private var replacementChar : String {

        if let result = objc_getAssociatedObject(self, &FKFieldPatterns.replacementChar) as? String {
            return result
        }
        return ""

    }
    
    /// <#Description#>
    private var allowText : Bool {

        if let result = objc_getAssociatedObject(self, &FKFieldPatterns.allowText) as? Bool {
            return result
        }
        
        return true

    }
    
    /// <#Description#>
    private var allowNumbers : Bool {

        if let result = objc_getAssociatedObject(self, &FKFieldPatterns.allowNumbers) as? Bool {
            return result
        }
        return true

    }
    
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - pattern: <#pattern description#>
    ///   - replacementChar: <#replacementChar description#>
    ///   - allowText: <#allowText description#>
    ///   - allowNumbers: <#allowNumbers description#>
    public func formatPattern(pattern:String?=nil, replacementChar:String?=nil,  allowText:Bool=true, allowNumbers:Bool=true) {

        objc_setAssociatedObject(self, &FKFieldPatterns.pattern,            pattern ?? "",         .OBJC_ASSOCIATION_RETAIN)
        objc_setAssociatedObject(self, &FKFieldPatterns.replacementChar,    replacementChar ?? "*", .OBJC_ASSOCIATION_RETAIN)
        objc_setAssociatedObject(self, &FKFieldPatterns.allowNumbers,       allowNumbers,    .OBJC_ASSOCIATION_RETAIN)
        objc_setAssociatedObject(self, &FKFieldPatterns.allowText,          allowText,       .OBJC_ASSOCIATION_RETAIN)
        registerNotifications()

    }
    
    /// <#Description#>
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name(rawValue: "UITextFieldTextDidChangeNotification"), object: self)
    }
    
    /// <#Description#>
    private func removeNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// <#Description#>
    ///
    /// - Parameter string: <#string description#>
    /// - Returns: <#return value description#>
    public func prepareString(string:String) -> String {

        var charSet : CharacterSet!
        
        if allowText && allowNumbers {
            charSet = CharacterSet.alphanumerics.inverted
        } else if allowText {
            charSet = CharacterSet.letters.inverted
        } else if allowNumbers {
            charSet = CharacterSet.decimalDigits.inverted
        }
        
        let result = string.components(separatedBy: charSet)
        return result.joined(separator: "")

    }
    
    /// <#Description#>
    ///
    /// - Parameter notification: <#notification description#>
    public func textDidChange(notification : NSNotification) {
        
        self.format()
        
    }
    
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    public func utext() -> String? {
        
        return self.text?.replacingOccurrences(of: ".", with: "")
                         .replacingOccurrences(of: "-", with: "")
                         .replacingOccurrences(of: "(", with: "")
                         .replacingOccurrences(of: ")", with: "")
                         .replacingOccurrences(of: " ", with: "")
        
    }
    
    /// <#Description#>
    public func format() {
        
        guard let text = self.text else {
            return
        }
        
        if text.characters.count > 0 && pattern.characters.count > 0 {
            
            var finalText   = ""
            var stop        = false
            let tempString  = prepareString(string: text)
            
            var formatIndex = pattern.startIndex
            var tempIndex   = tempString.startIndex
            
            while !stop {
                let formattingPatternRange = formatIndex ..< pattern.index(after: formatIndex)
                
                if pattern.substring(with: formattingPatternRange) != String(replacementChar) {
                    finalText = finalText.appending(pattern.substring(with: formattingPatternRange))
                }
                else if tempString.characters.count > 0 {
                    let pureStringRange = tempIndex ..< tempString.index(after: tempIndex)// tempIndex.advancedBy(1)
                    finalText = finalText.appending(tempString.substring(with: pureStringRange))
                    tempIndex = tempString.index(after: tempIndex)
                }
                
                formatIndex = pattern.index(after: formatIndex)
                
                if formatIndex >= pattern.endIndex || tempIndex >= tempString.endIndex {
                    stop = true
                }
                
                self.text = finalText
                
            }
            
        }

    }
    
    /// <#Description#>
    public func setupIMEIMask() {
        // 35 531908 188567 0
        self.formatPattern(pattern: "** ****** ****** *", replacementChar:"*", allowText: false, allowNumbers: true)
        self.keyboardType = .numberPad
    }
    
    /// <#Description#>
    public func setupCPFMask() {
        self.formatPattern(pattern: "***.***.***-**", replacementChar:"*", allowText: false, allowNumbers: true)
        self.keyboardType = .numberPad
    }
    
    /// <#Description#>
    public func setupCNPJMask() {
        self.formatPattern(pattern: "**.***.***/****-**", replacementChar:"*", allowText: false, allowNumbers: true)
        self.keyboardType = .numberPad
    }
    
    /// <#Description#>
    public func setupCEPMask() {
        self.formatPattern(pattern: "**.***-***", replacementChar:"*", allowText: false, allowNumbers: true)
        self.keyboardType = .numberPad
    }
    
    /// <#Description#>
    public func setupPhoneNumberMask() {
        self.formatPattern(pattern: "(**) *****-****", replacementChar:"*", allowText: false, allowNumbers: true)
        self.keyboardType = .numberPad
    }
    
}
