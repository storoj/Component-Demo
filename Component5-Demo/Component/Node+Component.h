//
// Created by Alexey Storozhev on 17/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "Node.h"

@class ComponentContext;
@class Component;

extern NSString *const kComponentNodeComponentKey;
extern NSString *const kComponentNodeContextKey;

@interface Node(Component)
@property (nonatomic, strong) __kindof Component *component;
@property (nonatomic, strong) ComponentContext *componentContext;
@property (nonatomic, assign, getter=isDynamic) BOOL dynamic;
@property (nonatomic, assign, getter=isUtility) BOOL utility;
@end
