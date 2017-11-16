//
//  ViewController.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 25/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class FBViewController: UIViewController, rootView {

    typealias viewType = FBView
    // MARK: Public properties
    
    var context: Context? {
        willSet {
            if let old = self.context {
                old.cancel()
            }
            
            newValue?.execute()
        }
    }
    
    var model: Model = Model() {
        didSet {
            oldValue.remove(self)
            
            self.model.add(self, for: .didLoad) { [weak self] model in
                self?.rootView.loadingView?.set(visible: false)
                self?.rootView.fill(with: model as! Model)
            }
            
            self.model.add(self, for: .willLoad) { [weak self] model in
                self?.rootView.loadingView?.set(visible: true)
            }
        }
    }
    
    var currentUser: CurrentUserModel = CurrentUserModel()
    
    // MARK: Initialization and Deallocation
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)   {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Public Methods
    
    func showViewController() {
        
    }
    
    func logout() {
        self.context = Context(model: self.currentUser);
    }
    
    // MARK: UI LifeCycle
    
    func prepareNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .done,
            target: self,
            action: #selector(FBViewController.onLogout)
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareNavigationBar();
    }

    func onLogout() {
        self.logout()
    }
    
}

