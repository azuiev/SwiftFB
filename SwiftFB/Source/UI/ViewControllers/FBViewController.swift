//
//  ViewController.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 25/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class FBViewController: UIViewController {

    // Public Properties
    
    var observationController: ObservableObject.ObservationController?
    
    var context: Context? {
        willSet {
            if let old = self.context {
                old.cancel()
            }
            
            newValue?.execute()
        }
    }
    
    var model: Model = Model() {
        didSet {
            self.observationController = self.model.controller(for: self)
        }
    }
    
    var currentUser: CurrentUserModel = CurrentUserModel()
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: toString(type(of: self)), bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Public Methods
    
    func showViewController() {
        
    }
    
    func logout() {
        self.context = LogoutContext(model: self.currentUser);
    }
    
    // MARK: UI LifeCycle
    
    func prepareNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .done,
            target: self,
            action: #selector(FBViewController.onLogout)
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

