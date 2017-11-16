//
//  LoginViewController.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class LoginViewController: FBViewController {
    
    // MARK: protocol rootView
    
    typealias viewType = LoginView
    
    // MARK: Public Properties
    
    override var model: Model {
        didSet {
            oldValue.remove(self)
            self.model.add(self, for: .willLoad) { [weak self] user in
                self?.showViewController()
            }
        }
    }
    
    // MARK: Public Methods
    
    override func showViewController() {
        let user = self.model as! CurrentUserModel
        let controller = UserViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        controller.model = user
        controller.currentUser = user;
        
        self.present(navigationController, animated: true)
    }
    
    // MARK: Private Methods
    
    func login() {
        self.context = LoginContext(currentUser:self.model as! CurrentUserModel)
    }
    
    // MARK: UI Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        self.rootView.loadingView?.set(visible: false)
    }
    
    @IBAction func onLogin() {
        self.login();
    }
}
