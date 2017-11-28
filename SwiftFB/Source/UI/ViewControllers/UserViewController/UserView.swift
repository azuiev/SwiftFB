//
//  UserView.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 11/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class UserView: FBView {

    // MARK: Public properties
    
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var surnameLabel: UILabel?
    @IBOutlet var middleNameLabel: UILabel?
    @IBOutlet var birthdayLabel: UILabel?
    @IBOutlet var genderLabel: UILabel?
    @IBOutlet var userImage: ImageView?
    
    @IBOutlet var FriendsButton: UIButton?

    // MARK: Public Methods
    
    func fill(with model: UserModel?) {
        self.nameLabel?.text = model?.name
        self.surnameLabel?.text = model?.surname
        self.middleNameLabel?.text = model?.middleName
        self.userImage?.model = model?.picture
        if let date = model?.birthday {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            self.birthdayLabel?.text = dateFormatter.string(from: date)
        }
    
        self.genderLabel?.text = model?.gender.rawValue;
    }
    
}
