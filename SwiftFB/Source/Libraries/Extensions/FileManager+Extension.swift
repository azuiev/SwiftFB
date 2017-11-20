//
//  FileManager+Extension.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 20/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

extension FileManager {
    
    typealias OperationBlock = (sourceURL: URL, destinationURL: URL, error: Error)
    
    func moveItem(from sourceUrl: URL, to destinationUrl: URL) -> Bool {
        self.performOperation(with: sourceUrl, destinationUrl: destinationUrl) {
            
        }
    }
    
    func performOperation(with sourceUrl: URL, destinationUrl: URL, operation: OperationBlock) -> Bool { (url1, url2, error) in
        //return self.move
    }
    
    /*
    - (BOOL)moveItemAtURL:(NSURL *)sourceURL toURL:(NSURL *)destinationURL {
    AZWeakify(self);
    
    return [self performOperationWithSourceURL:sourceURL
    destinationURL:destinationURL
    block:^BOOL(NSURL *url1, NSURL *url2, NSError *error) {
    AZStrongify(self);
    
    return [self moveItemAtURL:url1 toURL:url2 error:&error];
    }];
    
    }
    
    #pragma mark -
    #pragma mark Private Methods
    
    - (BOOL)performOperationWithSourceURL:(NSURL *)sourceURL
    destinationURL:(NSURL *)destinationURL
    block:(AZFileManagerBlock)block
    {
    if (![self checkSourceURL:sourceURL]
    || ![self checkDestinationURL:destinationURL]
    || !block)
    {
    return NO;
    }
    
    NSError *error = nil;
    
    BOOL result = block(sourceURL, destinationURL, error);
    if (!result) {
    NSLog(@"%@", error);
    }
    
    return result;
    }
 */
}
