//
//  LoginViewController.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class LoginViewController: UIViewController, RootView {
    
    // MARK: Protocol rootView
    
    typealias ViewType = LoginView
    
    // MARK: Public Properties
    
    var disposeBag = DisposeBag()
    var viewModel: LoginViewModel
    
    // MARK: Initialization
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: toString(type(of: self)), bundle: .main)
        
        self.viewModel.subject
            .subscribe(onNext: ({ [weak self] in
                _ = $0.map {
                    self?.finishLogging($0)
                }
            }))
            .disposed(by: self.disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: Public Methods
    
    func finishLogging(_ user: CurrentUserModel) {
        let controller = UserViewController(model: user, currentUser: user)
        let navigationController = UINavigationController(rootViewController: controller)
        self.present(navigationController, animated: true)
    }
    
    // MARK: UI Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.loadingView?.set(visible: false)
        
        self.rootView?.LoginButton?
            .rx
            .tap
            .subscribe(onNext: ({ [weak self] in
                self?.viewModel.tryLogin()
            }))
        .disposed(by: self.disposeBag)
        
    }
}
