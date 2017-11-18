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
    
    var contentImageView: UIImageView?
    var model: ImageModel?
    
    /*
    - (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    [self initSubviews];
    }
    
    return self;
    }
    
    - (void)awakeFromNib {
    [super awakeFromNib];
    
    if (!self.contentImageView) {
    [self initSubviews];
    }
    }
    
    - (void)initSubviews {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = AZViewResizableWithFixedPosition;
    
    self.contentImageView = imageView;
    }
    
    #pragma mark -
    #pragma mark Accessors
    
    - (void)setModel:(AZImageModel *)model {
    if (_model != model) {
    [_model removeObserver:self];
    
    _model = model;
    
    [_model addObserver:self];
    }
    
    model.state = AZModelDidUnload;
    [model load];
    }
    
    - (void)setContentImageView:(UIImageView *)contentImageView {
    if (_contentImageView != contentImageView) {
    [_contentImageView removeFromSuperview];
    _contentImageView = contentImageView;
    
    [self addSubview:contentImageView];
    [self bringSubviewToFront:self.loadingView];
    }
    }
    
    #pragma mark -
    #pragma mark Loading Model Observer
    
    - (void)modelDidUnload:(AZImageModel *)imageModel {
    
    }
    
    - (void)modelWillLoad:(AZImageModel *)imageModel {
    [AZGCD dispatchAsyncOnMainQueue:^ {
    [self.loadingView setVisible:YES];
    }];
    }
    
    - (void)modelDidLoad:(AZImageModel *)imageModel {
    [AZGCD dispatchAsyncOnMainQueue:^ {
    [self.loadingView setVisible:NO];
    
    self.contentImageView.image = imageModel.image;
    }];
    }
    
    - (void)modelDidFailLoad:(AZImageModel *)imageModel {
    [AZGCD dispatchAsyncOnMainQueue:^ {
    [self.model load];
    }];
    }
    */
}
