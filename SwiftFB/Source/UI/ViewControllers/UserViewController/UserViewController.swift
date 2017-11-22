//
//  UserViewController.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 11/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class UserViewController: FBViewController {

    // MARK: protocol rootView
    
    typealias ViewType = UserView
    
    // MARK: Public Properties
    
    var user: UserModel {
        guard let result = self.model as? UserModel else { return UserModel() }
        
        return result
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.context = UserContext(model: self.model, currentUser: self.currentUser);
    }
    
    private func showFriendsController() {
        let controller = FriendsViewController()
        controller.currentUser = self.currentUser
        controller.user = self.user
        controller.model = UsersModel()
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
