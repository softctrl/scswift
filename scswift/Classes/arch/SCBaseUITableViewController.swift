//
//  SCBaseUITableViewController.swift
//  SCSwift
//
//  Created by Timoshenko on 28/04/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation

import UIKit

class SCBaseUITableViewController: UITableViewController {
    
    private var dlg : SCDialogUtils?
    
    /// <#Description#>
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SCBaseUITableViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
        self.dlg = SCDialogUtils(view:self)
        self.setupNavigationBar()
        
    }
    
    /// <#Description#>
    public func setupNavigationBar() {}
    
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
    /// - Parameter title: <#title description#>
    public func setNavigationTitle(title : String) {
        self.navigationItem.title = title
    }
    
    public func setBackNavigationTitle(title : String) {
        self.navigationController?.navigationBar.topItem?.title = title
    }    
    
}
