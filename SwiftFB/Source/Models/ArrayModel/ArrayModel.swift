//
//  ArrayModel.swift
//  SwiftFB
//
//  Created by Aleksey Zuiev on 21/11/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

import UIKit

class ArrayModel: Model {
    
    // MARK: Public Properties
    
    var array: Array<Any> {
        get {
            return synchronized(lockObject: self) {
                return self.array
            }
        }
        
        set {
            
        }
    }
    
    var count: Int {
        get {
            return synchronized(lockObject: self) {
                return self.array.count
            }
        }
    }
    
    // MARK: Initialization
    
    init(array: Array<Any>) {
        super.init()
        
        self.array = array
        self.notify = true
    }
    
    // MARK: Public Methods
    
    func add(object: Any) {
        
    }
    
    func insert(object: Any?, at index: Int) {
        
        synchronized(lockObject: self) {
            guard let item = object, self.count >= index else { return }
            
            self.array[index] = item
 
       // [self notifyWithObject:[AZArrayModelChange arrayModelAddChangeWithIndex:index]];
        }
    }
}

/*
     #pragma mark -
    #pragma mark Public Methods
    
    - (void)addObject:(NSObject *)object {
    [self insertObject:object atIndex:self.count];
    }
    
    - (void)removeObject:(NSObject *)object {
    [self removeObjectAtIndex:[self.array indexOfObject:object]];
    }
    
    - (void)addObjects:(NSArray *)objects {
    for (id object in objects) {
    [self addObject:object];
    }
    }
    
    - (void)removeObjects:(NSArray *)objects {
    for (id object in objects) {
    [self removeObject:object];
    }
    }
    
    - (id)objectAtIndex:(NSUInteger)index {
    return self.count > index ? [self.mutableArray objectAtIndex:index] : nil;
    }
    
    - (void)setObject:(id)object atIndex:(NSUInteger)index {
    @synchronized (self) {
    if (object && self.count > index) {
    [self.mutableArray setObject:object atIndexedSubscript:index];
    }
    }
    }
    
    - (void)moveFromIndex:(NSUInteger)sourceIndex
    toIndex:(NSUInteger)destinationIndex
    {
    @synchronized (self) {
    if (sourceIndex != destinationIndex) {
    [self.mutableArray moveRowAtIndex:sourceIndex toIndex:destinationIndex];
    [self notifyWithObject:[AZArrayModelChange arrayModelMoveChangeFromIndex:sourceIndex
    toIndex:destinationIndex]];
    }
    }
    }
    
    #pragma mark -
    #pragma mark Private Methods
    
 
    
    - (void)removeObjectAtIndex:(NSUInteger)index {
    @synchronized (self) {
    if (self.count > index) {
    [self.mutableArray removeObjectAtIndex:index];
    [self notifyWithObject:[AZArrayModelChange arrayModelRemoveChangeWithIndex:index]];
    }
    }
    }
    
    - (void)notifyWithObject:(AZArrayModelChange *)arrayModelChange {
    [self setState:AZArrayModelChanged withObject:arrayModelChange];
    }
    
    #pragma mark -
    #pragma mark Subscripts
    
    - (id)objectAtIndexedSubscript:(NSUInteger)index NS_AVAILABLE(10_8, 6_0) {
    return [self objectAtIndex:index];
    }
    
    - (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)index {
    return [self setObject:obj atIndex:index];
    }
    
    #pragma mark -
    #pragma mark Observable Object
    
    - (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
    case AZArrayModelChanged:
    return @selector(arrayModelDidChange:withObject:);
    
    default:
    return [super selectorForState:state];
    }
    }
*/
