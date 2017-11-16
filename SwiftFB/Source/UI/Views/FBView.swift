//
//  FBView.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 03/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

protocol rootView {
    associatedtype viewType
    
    var rootView: viewType { get }
}

extension rootView where Self: UIViewController {
    var rootView: viewType {
        return (self.viewIfLoaded as? viewType)!
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
            let loadingView: LoadingView? = UINib.object(with: LoadingView.self) as? LoadingView
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
