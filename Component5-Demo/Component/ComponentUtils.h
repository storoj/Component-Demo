//
// Created by Alexey Storozhev on 18/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "Component.h"

extern void NodeAddToViewDemo1(UIView *host, NSArray <NodeChild *> *nodes);
extern void NodeAddToViewDemo2(UIView *host, NSArray <NodeChild *> *nodes);
extern void NodeAddToView(UIView *host, NSArray <NodeChild *> *nodes);
extern void NodeSimplifyVisitorBlock(Node *node, CGPoint origin, void(^block)(Node *node, CGPoint origin));
