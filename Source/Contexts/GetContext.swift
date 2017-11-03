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

    struct Constants {
        static let requestMethod = "GET"
    }
    // MARK: Public Methods
    
    func graphPath() -> String? {
        return nil
    }
    
    func parameters() -> Dictionary<String, String>? {
        return nil
    }
    
    func fbUserModel() -> Model {
        return self.model as Model
    }

    // MARK: Override Methods
    
    override func execute(with completionHandler: @escaping(ModelState) -> Void) {
        let request = GraphRequest(graphPath: self.graphPath()!)
        
        request.start() {
            (URLResponse, requestResult) in
            
            switch requestResult {
            case .failed(let error):
                print("error in graph request:", error)
            case .success(let graphResponse):
                if let responseDictionary = graphResponse.dictionaryValue {
                    print(responseDictionary)
                    completionHandler(.ModelDidLoad)
                }
            }
        }
        
    }
}
