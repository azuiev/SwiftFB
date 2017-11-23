//
//  ImageView.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 18/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class ImageView: FBView {

    // MARK: Public properties
    
    var contentImageView: UIImageView? {
        didSet {
            oldValue?.removeFromSuperview()
            if let newValue = self.contentImageView {
                self.addSubview(newValue)
                if let loadingView = self.loadingView {
                    self.bringSubview(toFront: loadingView)
                }
            }
        }
    }
    
    var model: ImageModel? {
        didSet {
            if let newValue = self.model {
                self.observationController = newValue.controller(for: self)
                newValue.state = .didUnload
                
                newValue.load()
            }
        }
    }
    
    var observationController: ObservableObject.ObservationController? {
        didSet {
            self.observationController?[.didLoad] = { [weak self] model, _ in
                guard let imageModel = model as? ImageModel else { return }
                self?.loadingView?.set(visible: false)
                self?.contentImageView?.image = imageModel.image
            }
            
            self.observationController?[.willLoad] = { [weak self] model, _ in
                self?.loadingView?.set(visible: true)
            }
            
            self.observationController?[.didFailLoading] = { [weak self] model, _ in
                self?.model?.load()
            }
        }
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initSubviews()
    }
    
    func initSubviews() {
        let imageView = UIImageView(frame: self.bounds)
        imageView.autoresizingMask = ViewConstants.ViewResizableWithFixedPosition
        
        self.contentImageView = imageView
    }
}
