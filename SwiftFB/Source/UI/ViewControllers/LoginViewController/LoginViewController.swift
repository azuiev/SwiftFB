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
    
    typealias ViewType = LoginView
    
    // MARK: Public Properties
    
    override var observationController: ObservableObject.ObservationController? {
        didSet {
            self.observationController?[.didLoad] = { [weak self] user in
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
        self.observationController = nil
        self.present(navigationController, animated: true)
    }
    
    // MARK: Private Methods
    
    func login() {
        guard let user = self.model as? CurrentUserModel else { return }
        self.context = LoginContext(currentUser:user)
    }
    
    // MARK: UI Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        self.rootView.loadingView?.set(visible: false)
    }
    
    @IBAction func onLogin() {
        self.login();
    }
}
