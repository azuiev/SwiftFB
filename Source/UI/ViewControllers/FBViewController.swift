//
//  ViewController.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 25/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class FBViewController: UIViewController {

    // MARK: Public properties
    
    let mainView = UIView()
    var context: Context? {
        willSet {
            if let old = self.context {
                old.cancel()
            }
            
            newValue?.execute()
        }
    }
    
    var model: Model
    var currentUser: Model
    
    // MARK: Initialization and Deallocation
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)   {
        self.model = Model()
        self.currentUser = Model()
        
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        self.model = Model()
        self.currentUser = Model()
        
        super.init(coder: aDecoder)
    }
    
    deinit {
        self.context = nil
        self.model = Model()
        self.currentUser = Model()
    }
    
    // MARK: Public Methods
    
    func showViewController() {
        
    }
    
    func logout() {
        self.context = Context(with: currentUser);
    }
    
    // MARK: UI LifeCycle
    
    func prepareNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .done,
            target: self,
            action: Selector("onLogout")
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareNavigationBar();
    }

    func onLogout() {
        self.logout()
    }
    
    
}

