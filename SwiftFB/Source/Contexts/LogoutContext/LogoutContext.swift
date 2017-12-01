//
//  LogoutContext.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 01/12/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class LogoutContext: Context {
    override func execute(withCompletion completionHandler: @escaping(ModelState) -> ()) {
        let manager = LoginManager()
        
        manager.logOut()
        guard let currentUser = self.model as? CurrentUserModel else { return }
        currentUser.token = nil
        
        completionHandler(.didUnload);
    }
}
