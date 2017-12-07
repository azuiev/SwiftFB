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
                print("error in graph request:", error)
            case .success(let graphResponse):
                if let responseDictionary = graphResponse.dictionaryValue {
                    self.finishLoading(with: responseDictionary)
                    completionHandler(.didLoad)
                }
            }
        }
    }
}
