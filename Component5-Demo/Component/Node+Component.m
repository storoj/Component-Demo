//
// Created by Alexey Storozhev on 17/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "Node+Component.h"
#import "Component.h"

NSString *const kComponentNodeComponentKey = @"Component";
NSString *const kComponentNodeContextKey = @"Context";
NSString *const kComponentNodeDynamicKey = @"Dynamic";
NSString *const kComponentNodeUtilityKey = @"Utility";

@implementation Node(Component)

- (Component *)component {
    return self[kComponentNodeComponentKey];
}

- (void)setComponent:(Component *)component {
    self[kComponentNodeComponentKey] = component;
}


- (ComponentContext *)componentContext {
    return self[kComponentNodeContextKey];
}

- (void)setComponentContext:(ComponentContext *)componentContext {
    self[kComponentNodeContextKey] = componentContext;
}


- (BOOL)isDynamic {
    return [self[kComponentNodeDynamicKey] boolValue];
}

- (void)setDynamic:(BOOL)dynamic {
    self[kComponentNodeDynamicKey] = @(dynamic);
}


- (BOOL)isUtility {
    return [self[kComponentNodeUtilityKey] boolValue];
}

- (void)setUtility:(BOOL)utility {
    self[kComponentNodeUtilityKey] = @(utility);
}

@end
