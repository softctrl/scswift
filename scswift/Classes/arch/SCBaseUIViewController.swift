//
//  SCBaseUIViewController.swift
//  SCSwift
//
//  Created by Timoshenko on 18/04/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import UIKit
import XCGLogger


//protocol SCUIViewController {
//    
//    func getTableView() -> UITableView
//
//}
//

class SCErrorBase : Error {}

class SCBaseUIViewController: UIViewController {
    
    let log : XCGLogger = {
        let _log = SCLogger.getInstance().log()
        return _log
    }()
    
    enum Return {
        case SUCCESS
        case ERROR
    }

    public typealias ReturnAction = (SCBaseUIViewController.Return) -> Swift.Void

    private var dlg : SCDialogUtils?
    
    private var hasMenuButton = false
    
    private var keyboardShowing : Bool = false
    
    private var oldContentInset : UIEdgeInsets?
    
    private var oldIndicatorInsets : UIEdgeInsets?
    
    private var oldOffset : CGPoint?
    
    private var returnAction : ReturnAction? = nil
    
    private var waitController : UIAlertController? = nil

    /// <#Description#>
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SCBaseUIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.dlg = SCDialogUtils(view:self)
        if hasMenuButton { self.setupMenuButton() }
        self.setupNavigationBar()
        if let scroll = self.getScrollView() {
           scroll.setupContentSize()
        }

    }
    
    /// <#Description#>
    ///
    /// - Parameter message: <#message description#>
    func presentWait(_ message : String = "") {

//        self.waitController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//
//        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 130, y: 10, width:37, height:37))
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//
//        self.waitController?.view.addSubview(loadingIndicator)
//        loadingIndicator.startAnimating();
//
//        self.present(self.waitController!, animated: true, completion: {
//            loadingIndicator.center = self.view.center // (self.waitController?.view.center)!
//        })
        
    }
    
    /// <#Description#>
    func dismissWait() {
//        self.waitController?.dismiss(animated: true, completion: nil);
//        self.waitController = nil
    }

    /// <#Description#>
    public func setupNavigationBar() {}
    
    /// <#Description#>
    private func setupMenuButton() {
        
        let icone = UIImage(named: "ic_dehaze")
        let menuButton = UIBarButtonItem(image: icone, style: UIBarButtonItemStyle.plain, target: self, action: #selector(SCBaseUIViewController.menuClicked))
        self.navigationItem.leftBarButtonItem = menuButton

    }
    
    /// <#Description#>
    ///
    /// - Parameter sender: <#sender description#>
    func menuClicked(sender:UIBarButtonItem?){}

    
    /// <#Description#>
    ///
    /// - Parameter value: <#value description#>
    /// - Returns: <#return value description#>
    public func addMenuButton(_ value: Bool! = true) -> SCBaseUIViewController {
        
        self.hasMenuButton = value
        return self

    }

    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    public func getDlg() -> SCDialogUtils? {
        return self.dlg
    }

    /// <#Description#>
    ///
    /// - Parameter rightBarButtonItems: <#rightBarButtonItems description#>
    public func setRightBarButtonItems(rightBarButtonItems: NSArray) {
        self.navigationItem.rightBarButtonItems = rightBarButtonItems as? [UIBarButtonItem]
    }
    
    /// <#Description#>
    func dismissKeyboard() {
        view.endEditing(true)
    }

    /// <#Description#>
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - uiViewController: <#uiViewController description#>
    ///   - animated: <#animated description#>
    func pushViewController(_ uiViewController : UIViewController, animated : Bool = false) {
        
        self.navigationController!.pushViewController(uiViewController, animated: animated)
        
    }

    /// <#Description#>
    ///
    /// - Parameters:
    ///   - viewControllerToPresent: <#viewControllerToPresent description#>
    ///   - animated: <#animated description#>
    ///   - completion: <#completion description#>
    func presentModal(_ viewControllerToPresent: UIViewController, animated: Bool = false, completion: (() -> Swift.Void)? = nil ) {

        self.navigationController!.present(viewControllerToPresent, animated: animated, completion : completion)

    }
    
    

    /// <#Description#>
    ///
    /// - Parameter title: <#title description#>
    public func setNavigationTitle(title : String) {
        self.navigationItem.title = title
    }
    
    /// <#Description#>
    ///
    /// - Parameter title: <#title description#>
    public func setBackNavigationTitle(title : String) {
        self.navigationController?.navigationBar.topItem?.title = title
    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    func getScrollView() -> UIScrollView? {
        return nil
    }
    
    /// <#Description#>
    ///
    /// - Throws: <#throws value description#>
    func setupKeyBoardSupport() throws {
        
        if self.getScrollView() == nil {
            throw SCErrorBase()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)

    }

    /// <#Description#>
    ///
    /// - Parameter n: <#n description#>
    func keyboardShow(_ n: Notification) {
        
        if self.keyboardShowing {
            return
        }
        self.keyboardShowing = true
        self.oldContentInset = self.getScrollView()?.contentInset
        self.oldIndicatorInsets = self.getScrollView()?.scrollIndicatorInsets
        self.oldOffset = self.getScrollView()?.contentOffset
        let d = n.userInfo!
        var r = d[UIKeyboardFrameEndUserInfoKey] as! CGRect
        r = (self.getScrollView()?.convert(r, from:nil))!
        self.getScrollView()?.contentInset.bottom = r.size.height
        self.getScrollView()?.scrollIndicatorInsets.bottom = r.size.height
        
    }

    /// <#Description#>
    ///
    /// - Parameter n: <#n description#>
    func keyboardHide(_ n: Notification) {
        
        if !self.keyboardShowing {
            return
        }
        self.keyboardShowing = false
        self.getScrollView()?.contentOffset = self.oldOffset!
        self.getScrollView()?.scrollIndicatorInsets = self.oldIndicatorInsets!
        self.getScrollView()?.contentInset = self.oldContentInset!
        
    }
    
    /// Use this method to set an action that can be performed wherever you want into your view controller 
    func action(_ returnAction : @escaping ReturnAction = {_ in }) -> SCBaseUIViewController {
        self.returnAction = returnAction
        return self
    }
    
    /// <#Description#>
    ///
    /// - Parameter code: <#code description#>
    func performAction(_ code: SCBaseUIViewController.Return! = SCBaseUIViewController.Return.SUCCESS) {
        self.returnAction?(code)
    }

}