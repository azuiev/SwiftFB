//
//  UserModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

enum Gender: String {
    case male
    case female
};

class UserModel: Model {
    
    // MARK: Constants
    
    private struct Constants {
        static let EmptyValue = "Empty"
        static let NameKey = "Name"
        static let SurnameKey = "Surname"
        static let PictureKey = "Picture"
    }
    
    // MARK: Protocol Hashable
    
    override var hashValue: Int {
        return self.fullName.hashValue
    }
    
    // MARK: Public Properties
    
    var name: String?
    var surname: String?
    var middleName: String?
    var userID: String?
    var birthday: Date? 
    var gender: Gender = .male
 
    var picture: ImageModel? {
        didSet {
            self.picture?.load()
        }
    }
    
    var fullName: String {
        return "\(self.name ?? Constants.EmptyValue) \(self.surname ?? Constants.EmptyValue)"
    }
    
    // MARK: Initialization

    override init() {
        super.init()
    }
    
    convenience init(name: String, surname: String, imagePath: String) {
        self.init()
        
        self.name = name
        self.surname = surname
        if let url = URL(string: imagePath) {
            self.picture = ImageModel(url: url)
        }
    }
}
