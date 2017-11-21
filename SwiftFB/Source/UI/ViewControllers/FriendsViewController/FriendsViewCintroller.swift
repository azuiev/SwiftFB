//
//  FriendsViewCintroller.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 21/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class FriendsViewCintroller: FBViewController {

    // MARK: protocol rootView
    
    typealias viewType = UserView
    
    // Public Properties
    var friends: Model {
        get {
            //guard let result = self.model as? Model else { return Model() }
            
            return self.model
        }
        
        set(newValue) {
            self.model = newValue
        }
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Friends"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.context = UserContext(model: self.friends, currentUser: self.currentUser);
    }
    
    // MARK: protocol UITableViewDataSource

    func tableView(table: UITableView, numberOfRowsInSection: Int) {
        //return self.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = tableView.reusableCell(with: UITableViewCell.self)
        
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
