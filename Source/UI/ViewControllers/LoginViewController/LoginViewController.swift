//
//  LoginViewController.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class LoginViewController: FBViewController {
    
    // MARK: Public Properties
    
    override var model: Model {
        didSet {
            oldValue.remove(self)
            self.model.add(self, for: .WillLoad) {user in
                self.showViewController()
            }
        }
    }
    
    // MARK: View Lifecycle
    
    @IBAction func onLogin() {
        self.login();
    }
  
    // MARK: Public Methods
    override func showViewController() {
        print("TEST")
    }
    
    // MARK: Private Methods
    
    func login() {
        self.context = LoginContext(with: self.model);
    }
}
