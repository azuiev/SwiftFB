//
//  ImageModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 18/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class ImageModel: Model {
    
    typealias CompletionBlock = (_ image: UIImage, _ error: Error) -> ()

    var image: UIImage?
    var imagePath: String?
    var url: URL
    
    func imageModel(with url: URL) -> ImageModel {
        let cache = ImageModelCache().sharedInstance
        var model = cache.object(with: url)
        
        if model == nil {
            //Class cls = [url isFileURL] ? [AZFileSystemImageModel class] : [AZInternetImageModel class];
            model = ImageModel(url: url)
            cache.set(object: model!, for: url)
        }
        
        return model!
    }
    
    // MARK: Initialization
    
    private init(url: URL) {
        self.url = url
        super.init()
    }
    
    // MARK: Public Methods
    
    func loadImage(with completionBlock: CompletionBlock) {
        
    }
    
    func cancel() {
        
    }
}
