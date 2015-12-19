//
// Created by Alexey Storozhev on 18/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "ComponentUtils.h"
#import "UIView+ComponentController.h"

static void NodeSimplifyVisitor(Node *node, CGPoint origin, NSMutableArray <NodeChild *> *acc)
{
    if ([node isDynamic]) {
        node = [node.component nodeForContext:node.componentContext];
    }

    if ([node isUtility]) {
        for (NodeChild *child in node.children) {
            NodeSimplifyVisitor(child.node, CGPointAddPoint(origin, child.origin), acc);
        };
    } else {
        [acc addObject:[NodeChild childWithNode:node atPoint:origin]];
    }
}

void NodeAddToViewDemo1(UIView *host, NSArray <NodeChild *> *nodes) {
    for (UIView *subview in host.subviews) {
        if (subview._vk_componentController != nil) {
            [subview removeFromSuperview];
        }
    }

    for (NodeChild *child in nodes) {
        Node *node = child.node;

        UIView *view = [UIView new];
        view.layer.borderWidth = 1;
        view.layer.borderColor = [[[UIColor redColor] colorWithAlphaComponent:0.7] CGColor];

        view.frame = (CGRect){ .origin = child.origin, .size = node.size };
        view._vk_componentController = [ComponentController new];

        [host addSubview:view];

        NodeAddToViewDemo1(view, node.children);
    }
}

void NodeAddToViewDemo2(UIView *host, NSArray <NodeChild *> *nodes) {
    for (UIView *subview in host.subviews) {
        if (subview._vk_componentController != nil) {
            [subview removeFromSuperview];
        }
    }

    NSMutableArray *children = [NSMutableArray array];
    for (NodeChild *child in nodes) {
        NodeSimplifyVisitor(child.node, child.origin, children);
    }

    for (NodeChild *child in children) {
        Node *node = child.node;

        Class controllerClass = [[node.component class] controllerClass];
        if (controllerClass) {
            UIView *view = [controllerClass createView];
            ComponentController *controller = [(ComponentController *)[controllerClass alloc] initWithView:view];

            [controller updateWithNode:node];

            view.layer.borderWidth = 0;
            view.layer.borderColor = [[[UIColor redColor] colorWithAlphaComponent:0.7] CGColor];

            view.frame = (CGRect){ .origin = child.origin, .size = node.size };

            [host addSubview:view];

            NodeAddToViewDemo2(view, node.children);
        }
    }
}


void NodeAddToView(UIView *host, NSArray <NodeChild *> *nodes) {
    NodeAddToViewDemo2(host, nodes);
}
