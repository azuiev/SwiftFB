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
        let cell = tableView.reusableCell(with: UserCell.self)

        cell?.userModel = self.friends[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.friends.moveRow(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    /*
     
     #pragma mark -
     #pragma mark UITableViewDelegate
     
     - (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
     return self.editingStyle;
     }
     
     - (void)    tableView:(UITableView *)tableView
     commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
     forRowAtIndexPath:(NSIndexPath *)indexPath
     {
     if (UITableViewCellEditingStyleDelete == editingStyle) {
     [self.users removeObjectAtIndex:indexPath.row];
     }
     
     if (UITableViewCellEditingStyleInsert == editingStyle) {
     [self.users insertObject:[AZUserModel new] atIndex:indexPath.row];
     }
     
     [self.mainView changeEditMode];
     }
     
     #pragma mark -
     #pragma mark Buttons Actions
     
     - (IBAction)insertUser:(id)sender {
     AZUsersModel *model = self.users;
     [model insertObject:[AZUserModel new] atIndex:AZRandomNumberWithMaxValue(model.count)];
     }
     
     - (IBAction)removeUser:(id)sender {
     AZUsersModel *model = self.users;
     [model removeObjectAtIndex:AZRandomNumberWithMaxValue(model.count - 1)];
     }
     
     - (IBAction)changeMoveMode:(id)sender {
     self.editingStyle = UITableViewCellEditingStyleNone;
     [self.mainView changeEditMode];
     }
     
     - (IBAction)changeEditMode:(id)sender {
     self.editingStyle = UITableViewCellEditingStyleInsert;
     [self.mainView changeEditMode];
     }
     
     - (IBAction)changeDeleteMode:(id)sender {
     self.editingStyle = UITableViewCellEditingStyleDelete;
     [self.mainView changeEditMode];
     }
     
     #pragma mark -
     #pragma mark AZArrayModelObserver
     
     - (void)arrayModelDidChange:(AZArrayModel *)arrayModel withObject:(AZArrayModelChange *)object {
     [self.mainView.tableView applyChangesWithObject:object];
     }
*/
}
