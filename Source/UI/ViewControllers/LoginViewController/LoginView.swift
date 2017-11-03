//
//  LoginView.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class LoginView: FBView {
    
    // MARK: Public properties
    
    @IBOutlet var LoginButton: UIButton?
    
    // MARK: View Lifecycle
    
    @IBAction func onLoginButton(sender: UIButton) {
        print("Pressed login")
    }
    
}
