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
    
    override func fill(with model: Model) {
        guard let user = model as? UserModel else { return }
        self.nameLabel?.text = user.name
        self.surnameLabel?.text = user.surname
        self.middleNameLabel?.text = user.middleName
        self.userImage?.model = user.picture
        if let date = user.birthday {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            self.birthdayLabel?.text = dateFormatter.string(from: date)
        }
    
        self.genderLabel?.text = user.gender.rawValue;
    }
    
}
