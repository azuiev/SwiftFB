//
//  ViewController.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 25/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FBViewController: UIViewController {

    // Public Properties
    
    var disposeBag = DisposeBag()
    
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
        var logoutButton = UIBarButtonItem(
            title: "Logout",
            style: .done,
            target: self,
            action: nil
        )
        
        logoutButton
            .rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                self?.logout()
            })
            .disposed(by: self.disposeBag)
        
        self.navigationItem.rightBarButtonItem = logoutButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareNavigationBar();
    }

    @objc func onLogout() {
        self.logout()
    }
}

