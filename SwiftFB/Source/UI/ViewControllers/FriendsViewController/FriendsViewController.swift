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
            self.observationController?[.didLoad] = { [weak self] model in
                self?.rootView.loadingView?.set(visible: false)
                self?.rootView.tableView?.reloadData()
            }
            
            self.observationController?[.willLoad] = { [weak self] model in
                self?.rootView.loadingView?.set(visible: true)
            }
        }
    }
    
    var friends: UsersModel {
        guard let result = self.model as? UsersModel else { return UsersModel() }
        
        return result
    }
    
    var user: UserModel = UserModel()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Friends"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.context = FriendsContext(model: self.model, user: self.user, currentUser: self.currentUser);
    }

    // MARK: protocol UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = tableView.reusableCell(with: UserCell.self)
        
        if cell == nil {
            
        }
        
        return cell!
    }
    /*
    
    #pragma mark -
    #pragma mark UITableViewDelegate
    
    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AZFBUserViewController *controller = [AZFBUserViewController new];
    controller.currentUser = self.currentUser;
    controller.user = self.friends[indexPath.row];
    
    [self.navigationController pushViewController:controller animated:YES];
    }
    
    #pragma mark -
    #pragma mark Model Observer
    
    - (void)modelDidLoad:(AZModel *)model {
    [AZGCD dispatchAsyncOnMainQueue:^ {
    [self.mainView.loadingView setVisible:NO];
    [self.mainView.tableView reloadData];
    }];
    }
    
    @end
*/
}
