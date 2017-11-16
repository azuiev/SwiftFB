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
    
    typealias viewType = UserView
    
    // MARK: View Lifecycle
    
    @IBAction func onFriends() {
        self.showViewController();
    }
    
    // MARK: Public Methods
    
    override func showViewController() {
        print("show friends controller")
    }
    
    // MARK: UI Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.context = UserContext(model: self.model, currentUser: self.currentUser);
    }
}
