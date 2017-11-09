//
//  LoadingView.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 09/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    // MARK: Private Properties
    
    struct Constants {
        static let MaxAnimationDuration = 1.5
        static let MinAnimationDuration = 0.0
        static let MaxAlpha: CGFloat = 1.0
        static let MinAlpha: CGFloat = 0.0
    }
    
    // MARK: Public Properties
    
    var visible: Bool = true
    
    // MARK: Initialization
    
    init(superView: UIView) {
        super.init(frame: superView.bounds)
        superView.addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    
    @IBOutlet private var activityIndicator: UIActivityIndicatorView?

    func set(visible: Bool, animated: Bool = true, completionHandler: ((Bool) -> ())? = nil) {
        self.activityIndicator?.startAnimating()
        
        UIView.animate(withDuration: animated ? Constants.MaxAnimationDuration : Constants.MinAnimationDuration,
                       animations: { self.alpha = visible ? Constants.MaxAlpha : Constants.MinAlpha },
                       completion: { complete in
                        self.visible = visible
                        if let block = completionHandler {
                            block(complete)
                        }
        })
    }
}
