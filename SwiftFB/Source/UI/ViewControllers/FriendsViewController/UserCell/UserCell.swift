//
//  UserCell.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 22/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    // MARK: IBOutlet
    
    @IBOutlet var userImageView: ImageView?
    @IBOutlet var fullNameLabel: UILabel?
    
    // MARK Public Properties
    
    var userModel: UserModel? {
        didSet(newValue) {
            if newValue != nil {
                self.fill(with: newValue!)
            }
        }
    }
    
    func fill(with model: UserModel) {
        self.fullNameLabel?.text = model.fullName
        self.userImageView?.model = model.picture
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.userImageView?.contentImageView = nil
    }
}
