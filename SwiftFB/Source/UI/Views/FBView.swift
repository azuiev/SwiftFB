//
//  FBView.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

protocol RootView {
    associatedtype ViewType
    
    var rootView: ViewType { get }
}

extension RootView where Self: UIViewController {
    var rootView: ViewType {
        return (self.viewIfLoaded as? ViewType)!
    }
}

class FBView: UIView {
    
    var loadingView: LoadingView?
    
    // MARK: Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addLoadingView()
    }
    
    // MARK: Public Methods
    
    func addLoadingView() {
        if self.loadingView == nil {
            let loadingView: LoadingView? = UINib.object(with: LoadingView.self)
            if let view = loadingView {
                view.frame = self.bounds
                
                self.addSubview(view)
                
                self.loadingView = view;
            }
        }
    }
    
    func fill(with model: Model) {
        
    }
}
