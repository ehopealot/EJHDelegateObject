//
//  EJHDelegateObject.m
//  EJHDelegateObjectExample
//
//  Created by Erik Hope on 3/15/13.
//  Copyright (c) 2013 ehope. All rights reserved.
//

#import "EJHDelegateObject.h"
#import <objc/runtime.h>

static NSInteger counter;

@implementation EJHDelegateObject

+ (id)delegateObjectForProtocol:(Protocol *)protocol 
{
    NSString *className = [NSString stringWithFormat:@"%s%@%i",protocol_getName(protocol),@"_EJH_implementation_", counter++];
    Class protocolClass = objc_allocateClassPair([EJHDelegateObject class], [className cStringUsingEncoding:NSUTF8StringEncoding], 0);
    objc_registerClassPair(protocolClass);
    EJHDelegateObject *object = [[protocolClass alloc] init];
    object.protocol = protocol;
    return object;
}


- (void)addImplementation:(id)blockImplementation forSelector:(SEL)selector
{
    unsigned int outCount;
    struct objc_method_description *methodDescriptions = protocol_copyMethodDescriptionList(self.protocol, NO, YES, &outCount);
    struct objc_method_description description;
    BOOL descriptionFound = NO;
    for (int i = 0; i < outCount; i++){
        description = methodDescriptions[i];
        if (description.name == selector){
            descriptionFound = YES;
            break;
        }
    }
    if (descriptionFound){
        class_addMethod([self class], selector, imp_implementationWithBlock(blockImplementation), description.types);
    }
}

@end
