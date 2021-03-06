//
//  UsersModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 21/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class UsersModel: ArrayModel<UserModel>, Save {
    
    var plistName = "users.plist"
    var notificationList = [NSNotification.Name.UIApplicationDidEnterBackground, NSNotification.Name.UIApplicationWillTerminate]
    
    // MARK: Initializtion and Deallocation
    
    deinit {
        self.unsubscribeToNotifications()
    }
    
    init(users: [UserModel]) {
        super.init(array: users)
        
        self.subscribeToNotifications()
    }
    
    convenience init() {
        self.init(users: [UserModel]())
    }
    
    // MARK: Loading Model
    
    override func performLoading() {
         self.state = .didLoad
    }
    
    // MARK: Protocol Save
    
    func save() {
        print("Should be saved")
    }
    
    // MARL: Private Methods
    
    private func subscribeToNotifications() {
        self.notificationList.forEach {
            NotificationCenter.default.addObserver(forName: $0,
                                                   object: nil,
                                                   queue: nil)
            { [weak self] notification in
                print("Received the notification \(notification)")
                
                self?.save()
            }
        }
    }
    
    private func unsubscribeToNotifications() {
        self.notificationList.forEach {
            NotificationCenter.default.removeObserver(self,
                                                      name: $0,
                                                      object: nil)
        }
    }
    
    private func fullPlistName() -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        
        let result = documentsPath?.appending("/\(self.plistName)") ?? ""
        
        return result
    }
}
