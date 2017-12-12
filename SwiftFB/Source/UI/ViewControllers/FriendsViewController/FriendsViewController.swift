//
//  FriendsViewController.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 21/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

// MARK: Protocol RootView

extension FriendsViewController {
    typealias ViewType = FriendsView
}

class FriendsViewController: FBViewController, UITableViewDelegate, UITableViewDataSource {

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
            
            self.observationController?[.didUnload] = { [weak self] model, _ in
                self?.dismiss(animated: true, completion: nil)
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
        super.init()
        
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
        
        let nib = UINib(nibName: toString(UserCell.self), bundle: .main)
        
        self.rootView.tableView?.register(nib, forCellReuseIdentifier: toString(UserCell.self))
        self.rootView.tableView?.isEditing = true
        
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
        if sourceIndexPath.row == destinationIndexPath.row { return }
        
        self.friends.moveRow(from: sourceIndexPath.row, to: destinationIndexPath.row)
        
        self.rootView.tableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    // MARK: protocol UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.friends[indexPath.row]
            .map() { [weak self] in
                guard let user = self?.currentUser else { return }
                let controller = UserViewController(model: $0, currentUser: user)
                
                self?.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
