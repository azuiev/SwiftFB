//
//  ImageModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 18/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class ImageModel: Model {
    
    // MARK: Constants
    
    private struct Constants {
        static let URLKey         = "URL"
        static let ImageDirectory = "/Images/"
        static let LoadImageDelay = 0.5
    }
    
    typealias CompletionBlock = (UIImage?, Error?) -> ()

    
    // MARK: Protocol Hashable
    
    override public var hashValue: Int {
        return self.url.hashValue
    }
    
    // MARK: Public properties
    
    var image: UIImage?
    var imagePath: String? {
        get {
            let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            
            return documentPath?.appending(Constants.ImageDirectory)
        }
    }
    
    var url: URL
    
    // MARK: Initialization
    
    static func model(with url: URL) -> ImageModel {
        let cache = Cache.shared(ImageModel.self)
        var model = cache.object(with: url)
        
        if model == nil {
            model = url.isFileURL ? FileSystemImageModel(url: url) : InternetImageModel(url: url)
            cache.set(object: model, for: url)
        }
        
        return (model as? ImageModel)!
    }
    
    init(url: URL) {
        self.url = url
        super.init()
    }
    
    //MARK: Override Methods
    
    override func performLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.LoadImageDelay) { [weak self] in
            self?.loadImage { (image, error) in
                DispatchQueue.main.async {
                    self?.image = image
                    self?.state = image != nil ? .didLoad : .didFailLoading
                }
            }
        }
    }

    // MARK: Public Methods
    
    func loadImage(with completionBlock: @escaping CompletionBlock) {
        
    }
    
    func cancel() {
        
    }
    
    // MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let url = decoder.decodeObject(forKey: Constants.URLKey) as? URL else { return nil }
    
        self.init(url: url)
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encode(self.url, forKey: Constants.URLKey)
    }
}
