//
//  UserView.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 11/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class UserView: FBView {

    // MARK: Public Properties
    
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var surnameLabel: UILabel?
    @IBOutlet var middleNameLabel: UILabel?
    @IBOutlet var birthdayLabel: UILabel?
    @IBOutlet var genderLabel: UILabel?
    @IBOutlet var userImage: ImageView?
    
    @IBOutlet var FriendsButton: UIButton?

    // MARK: Public Methods
    
    func fill(with viewModel: UserViewModel) {
        self.nameLabel?.text = viewModel.name
        self.surnameLabel?.text = viewModel.surname
        self.middleNameLabel?.text = viewModel.middlename
        self.userImage?.model = viewModel.picture
        self.birthdayLabel?.text = viewModel.birthdayAsString()
        self.genderLabel?.text = viewModel.gender
    }
}
