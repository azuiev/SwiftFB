//
//  FriendsViewController.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 21/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class FriendsViewController: FBViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: protocol RootView
    
    typealias ViewType = FriendsView
    
    // Public Properties

    var rootView: FriendsView {
        return (self.viewIfLoaded as? FriendsView)!
    }
    
    override var observationController: ObservableObject.ObservationController? {
        didSet {
            self.observationController?[.didLoad] = { [weak self] model, _ in
                self?.rootView.loadingView?.set(visible: false)
                self?.rootView.tableView?.reloadData()
            }
            
            self.observationController?[.willLoad] = { [weak self] model, _ in
                self?.rootView.loadingView?.set(visible: true)
            }
            
            self.observationController?[.didChange] = { [weak self] model, options in
                guard let arrayOptions = options as? ArrayModelOption else { return }
                self?.rootView.tableView?.applyChanges(with: arrayOptions)
            }
        }
    }
    
    var friends: UsersModel {
        guard let result = self.model as? UsersModel else { return UsersModel() }
        
        return result
    }
    
    var user: UserModel = UserModel()
    
    // MARK: Initialization
    
    init(model: Model, user: UserModel, currentUser: CurrentUserModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.model = model
        self.user = user
        self.currentUser = currentUser
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: UI Actions
    
    func onDelete() {
        let user = self.friends.first()
        if let deleteUser = user {
            self.friends.remove(object: deleteUser)
        }
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "UserCell", bundle: nil)
        
        self.rootView.tableView?.register(nib, forCellReuseIdentifier: String.toString(UserCell.self))
        
        self.title = "Friends"
        self.context = FriendsContext(model: self.model, user: self.user, currentUser: self.currentUser);
    }
    
    override func prepareNavigationBar() {
        super.prepareNavigationBar()
        self.navigationItem.rightBarButtonItems?.append(UIBarButtonItem(
            title: "Delete",
            style: .done,
            target: self,
            action: #selector(FriendsViewController.onDelete)
        ))
    }
    
    // MARK: protocol UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(with: UserCell.self, indexPath: indexPath)

        cell.userModel = self.friends[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.friends.moveRow(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    // MARK: protocol UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let friend = self.friends[indexPath.row] else { return }
        let controller = UserViewController(model: friend, currentUser: self.currentUser)
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
