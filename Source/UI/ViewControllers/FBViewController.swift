//
//  ViewController.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 25/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class FBViewController: UIViewController, rootView {

    typealias viewType = FBView
    // MARK: Public properties
    
    var context: Context? {
        willSet {
            if let old = self.context {
                old.cancel()
            }
            
            newValue?.execute()
        }
    }
    
    var model: Model {
        didSet {
            oldValue.remove(self)
            
            self.model.add(self, for: .DidLoad) {model in
                self.showViewController()
            }
            
            self.model.add(self, for: .WillLoad) {model in
                self.rootView.loadingView?.set(visible: true)
            }
        }
    }
    
    var currentUser: CurrentUserModel?
    
    // MARK: Initialization and Deallocation
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)   {
        self.model = Model()

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.model = Model()
        
        super.init(coder: aDecoder)
    }
    
    // MARK: Public Methods
    
    func showViewController() {
        
    }
    
    func logout() {
        if let user = self.currentUser {
            self.context = Context(with: user);
        }
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

