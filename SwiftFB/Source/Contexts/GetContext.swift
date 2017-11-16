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

    // MARK: Constants
    
    private struct Constants {
        static let requestMethod = "GET"
    }
    
    // MARK: Public Properties
    
    var graphPath = ""
    var parameters: [String : String] = [:]
    var currentUser: CurrentUserModel
    
    // MARK: Initialization
    
    init?(model: Model, currentUser: CurrentUserModel) {
        self.currentUser = currentUser
        super.init(model: model)
    }
    
    // MARK: Public Methods
    
    func token() -> String? {
        return self.currentUser.token;
    }
    
    func finishLoading(with response: [String : Any]) {
        self.fill(model: self.model, with: response)
    }
    
    func fill(model: Model, with response: [String : Any]) {
        guard let user = model as? UserModel else { return }
        
        UserParser.update(user: user, with: response)
    }

    // MARK: Override Methods
    
    override func execute(with completionHandler: @escaping(ModelState) -> Void) {
        let request = GraphRequest(graphPath: self.graphPath, parameters: self.parameters)
        
        request.start() {
            (URLResponse, requestResult) in
            
            switch requestResult {
            case .failed(let error):
                print("error in graph request:", error)
            case .success(let graphResponse):
                if let responseDictionary = graphResponse.dictionaryValue {
                    print(responseDictionary)
                    self.finishLoading(with: responseDictionary)
                    completionHandler(.didLoad)
                }
            }
        }
        
    }
}
