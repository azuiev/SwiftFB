//
//  UsersModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 21/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class UsersModel: ArrayModel<UserModel> {
    
    var plistName = "users.plist"
    
    // MARK: Initializtion and Deallocation
    
    deinit {
        //self.unsubscribeToNotification()
    }
    
    init(users: [UserModel]) {
        super.init(array: users)
        
        //self.subscribeToNotifications()
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
    /*
 
    - (void)save {
    [NSKeyedArchiver archiveRootObject:self.array toFile:[self plistName]];
    }
    
    #pragma mark -
    #pragma mark Private
    
    - (NSString *)fullPlistName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *result = [paths firstObject];
    
    result = [result stringByAppendingPathComponent:self.plistName];
    
    return result;
    }
    
    - (NSString *)plistName {
    return self.mutablePlistName;
    }
    
    - (void)subscribeToNotification {
    NSArray *notifications = [self notificationList];
    
    AZWeakify(self);
    for (NSString *notification in notifications) {
    [[NSNotificationCenter defaultCenter] addObserverForName:notification
    object:nil
    queue:nil
    usingBlock:^(NSNotification *note) {
    AZStrongify(self);
    NSLog(@"Received the notification!");
    [self save];
    }];
    }
    }
    
    - (void)unsubscribeToNotification {
    NSArray *notifications = [self notificationList];
    
    for (NSString *notification in notifications) {
    [[NSNotificationCenter defaultCenter] removeObserver:self
    name:notification
    object:nil];
    }
    }
    
    - (NSArray *)notificationList {
    return @[@"UIApplicationDidEnterBackgroundNotification", @"UIApplicationWillTerminateNotification"];
    }
    
    - (void)initPlist {
    self.mutablePlistName = @"users.plist";
    }
    @end
 */
}
