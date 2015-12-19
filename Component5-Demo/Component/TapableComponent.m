//
// Created by Alexey Storozhev on 18/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "TapableComponent.h"

@implementation TapableComponent

- (__kindof Node *)nodeForState:(Component *)component context:(ComponentContext *)context {
    Node *componentNode = [component nodeForContext:[context copy]];
    
    Node *node = [super nodeForState:component context:context];
    node.size = CGSizeNormalize(CGSizeWithConstraints(componentNode.size, context.size));
    node.children = @[ [NodeChild childWithNode:componentNode] ];
    
    return node;
}

@end

@implementation TapableComponentController

+ (__kindof UIView *)createView {
    return [UIButton buttonWithType:UIButtonTypeCustom];
}

- (instancetype)initWithView:(UIButton *)button {
    self = [super initWithView:button];
    if (self) {
        [button addTarget:self action:@selector(actionTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)actionTap:(id)actionTap {
    NSLog(@"Tap!");
}

@end
