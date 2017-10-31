//
//  ViewController.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 25/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    let mainView = UIView()
    var context: Model
    var model: Model
    var currentUser: Model
    
    deinit {
        self.context = nil;
        self.model = nil;
        self.currentUser = nil;
    }
    
    func prepareNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
        title: "Logout",
        style: .UIBarButtonItemStyleDone,
        target: self,
        action: #selector(onLogout))
    }
    
    func showViewController() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareNavigationBar();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

