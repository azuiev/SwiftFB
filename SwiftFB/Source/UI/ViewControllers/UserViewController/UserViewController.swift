//
//  UserViewController.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 11/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

// MARK: Protocol RootView

extension UserViewController {
    typealias ViewType = UserView
}

class UserViewController: FBViewController, RootView {

    // MARK: Public properties
    
    override var observationController: ObservableObject.ObservationController? {
        didSet {
            self.observationController?[.didLoad] = { [weak self] model, _ in
                self?.rootView?.loadingView?.set(visible: false)
                self?.rootView?.fill(with: model as? UserModel)
            }
            
            self.observationController?[.willLoad] = { [weak self] model, _ in
                self?.rootView?.loadingView?.set(visible: true)
            }
            
            self.observationController?[.didUnload] = { [weak self] model, _ in
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    var user: UserModel {
        guard let result = self.model as? UserModel else { return UserModel() }
        
        return result
    }
    
    // MARK: Initialization
    
    init(model: Model, currentUser: CurrentUserModel) {
        super.init()
        
        self.model = model
        self.currentUser = currentUser
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Public Methods
    
    override func showViewController() {
        self.showFriendsController()
    }
    
    // MARK: IBActions
    
    @IBAction func onFriends() {
        self.showViewController();
    }

    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.context = UserContext(model: self.model, currentUser: self.currentUser);
    }
    
    private func showFriendsController() {
        let controller = FriendsViewController(model: UsersModel(), user: self.user, currentUser: self.currentUser)
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
