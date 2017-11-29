//
//  LoginViewController.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class LoginViewController: FBViewController, RootView {
    
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
    
    // MARK: Initialization
    
    init(model: Model) {
        super.init(nibName: nil, bundle: nil)
        
        self.model = model
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Public Methods
    
    override func showViewController() {
        guard let user = self.model as? CurrentUserModel else { return }
        let controller = UserViewController(model: self.model, currentUser: user)
        let navigationController = UINavigationController(rootViewController: controller)
        self.observationController = nil
        self.present(navigationController, animated: true)
    }
    
    // MARK: Private Methods
    
    func login() {
        guard let user = self.model as? CurrentUserModel else { return }
        self.context = LoginContext(currentUser:user)
    }
    
    // MARK: UI Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.loadingView?.set(visible: false)
    }
    
    @IBAction func onLogin() {
        self.login();
    }
}
