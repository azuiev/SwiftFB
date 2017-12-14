//
//  GetContext.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class GetContext: Context {
    
    // MARK: Public Properties
    
    var graphPath: String { return "" }
    var user: UserModel? 
    var parameters: [String : String] { return [:] }
    var currentUser: CurrentUserModel
    
    // MARK: Initialization
    
    init(model: Model, currentUser: CurrentUserModel) {
        self.currentUser = currentUser
        
        super.init(model: model)
    }
    
    // MARK: Public Methods
    
    func token() -> String? {
        return self.currentUser.token;
    }
    
    func finishLoading(with response: [String : Any]) {
        
    }

    // MARK: Override Methods
    
    override func execute(withCompletion completionHandler: @escaping(ModelState) -> Void) {
        model.state = .willLoad
        
        let request = GraphRequest(graphPath: self.graphPath, parameters: self.parameters)
        
        request.start() {
            (URLResponse, requestResult) in
            
            switch requestResult {
            case .failed(let error):
                print("Error \(error). Trying to load data from FS")
                self.loadSavedResponse()
                    .map { [weak self] in
                        self?.finishLoading(with: $0)
                        
                        completionHandler(.didLoad)
                }
            case .success(let graphResponse):
                graphResponse.dictionaryValue
                    .map { [weak self] in
                        self?.save(response: $0)
                        self?.finishLoading(with: $0)
                        
                        completionHandler(.didLoad)
                }
            }
        }
    }
    
    // MARK: Private methods
    
    func save(response : JSON) {
        NSKeyedArchiver.archiveRootObject(response, toFile: self.fileName())
    }
    
    func loadSavedResponse() -> [String : Any]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: self.fileName()) as? [String : Any]
    }
    
    func fileName() -> String {
        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path {
            return path.appending("/").appending(self.graphPath)
        } else {
            return ""
        }
    }
}

