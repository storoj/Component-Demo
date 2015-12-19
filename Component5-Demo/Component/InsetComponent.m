//
// Created by Alexey Storozhev on 18/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "InsetComponent.h"

@implementation InsetComponentState
@end

@implementation InsetComponent
@dynamic state;

+ (instancetype)component:(Component *)component withInsets:(UIEdgeInsets)insets {
    InsetComponentState *state = [InsetComponentState new];
    state.component = component;
    state.insets = insets;

    return [[self alloc] initWithState:state];
}

- (__kindof Node *)nodeForState:(InsetComponentState *)state context:(ComponentContext *)context {
    const UIEdgeInsets insets = state.insets;
    const CGFloat hInsets = insets.left + insets.right;
    const CGFloat vInsets = insets.top + insets.bottom;

    ComponentSize childSize = context.size;
    childSize.min = CGSizeInset(childSize.min, hInsets, vInsets);
    childSize.max = CGSizeInset(childSize.max, hInsets, vInsets);

    ComponentContext *childContext = [context copy];
    childContext.size = childSize;

    Node *componentNode = [state.component nodeForContext:childContext];
    const CGSize size = CGSizeInset(componentNode.size, -hInsets, -vInsets);

    Node *node = [super nodeForState:state context:context];
    node.size = CGSizeWithConstraints(CGSizeNormalize(size), context.size);
    node.children = @[
        [NodeChild childWithNode:componentNode
                         atPoint:CGPointMake(insets.left, insets.top)]
    ];
    node.utility = YES;

    return node;
}

@end
