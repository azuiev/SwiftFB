//
//  UserViewModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 21/12/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import Foundation

class UserViewModel {
    
    // MARK: Public Properties
    
    var name:               String          { return self.user.name ?? "" }
    var surname:            String          { return self.user.surname ?? "" }
    var middlename:         String          { return self.user.middleName ?? "" }
    var picture:            ImageModel?     { return self.user.picture }
    var gender:             String          { return self.user.gender.rawValue }
    
    var fullName: String {
        return [self.user.name, self.user.surname]
            .flatMap { $0 }
            .joined(separator: " ")
    }
    
    // MARK: Initialization
    
    init(userModel: UserModel) {
        self.user = userModel
    }
    
    // MARK: Private Properties
    
    private var user: UserModel
    
    func birthdayAsString(dateFormat: String = "MM/dd/yyyy") -> String {
        return self.user.birthday
            .map {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = dateFormat
                return dateFormatter.string(from: $0)
        } ?? ""
    }
}
