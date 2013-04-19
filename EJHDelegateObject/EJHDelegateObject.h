//
//  EJHDelegateObject.h
//  EJHDelegateObjectExample
//
//  Created by Erik Hope on 3/15/13.
//  Copyright (c) 2013 ehope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EJHDelegateObject : NSObject

+ (id)delegateObjectForProtocol:(Protocol*) protocol;

@property (nonatomic, strong) Protocol *protocol;

- (void)addSelector:(SEL)selector withImplementation:(id)blockImplementation;

@end
