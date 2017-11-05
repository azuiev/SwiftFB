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
    
    override var currentUser: CurrentUserModel {
        didSet {
            oldValue.remove(self)
            currentUser.add(self)
        }
    }
    
    // MARK: View Lifecycle
    
    @IBAction func onLogin() {
        self.login();
    }
    
    // MARK: Private Methods 
    
    func login() {
        self.context = LoginContext(with: self.currentUser);
    }
}
