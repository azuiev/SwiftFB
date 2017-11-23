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
        let array = NSKeyedUnarchiver.unarchiveObject(withFile: self.plistName)
        
        guard let users = array as? [UserModel] else { self.state = .didFailLoading; return }
        
        self.add(objects: users)
        self.state = .didLoad
    }
    
    // MARK: Protocol Save
    
    func save() {
        NSKeyedArchiver.archiveRootObject(self.array, toFile: self.plistName)
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
    
    /*
    - (NSString *)fullPlistName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *result = [paths firstObject];
    
    result = [result stringByAppendingPathComponent:self.plistName];
    
    return result;
    }
   */
}
