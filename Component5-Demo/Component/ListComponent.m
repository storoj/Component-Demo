//
// Created by Alexey Storozhev on 17/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "ListComponent.h"

@implementation ListComponentState
@end

@implementation ListComponent
@dynamic state;

+ (instancetype)list:(ListComponentState *)state {
    return [[self alloc] initWithState:state];
}

+ (instancetype)build:(ListComponentBuilderBlock)buildBlock completion:(void(^)(ListComponentState *s))completion {
    NSMutableArray *components = [NSMutableArray array];
    buildBlock(^(Component *component){
        if (component) {
            [components addObject:component];
        }
    });
    ListComponentState *state = [ListComponentState new];
    state.components = [components copy];

    if (completion) {
        completion(state);
    }

    return [self list:state];
}

+ (instancetype)build:(ListComponentBuilderBlock)buildBlock {
    return [self build:buildBlock completion:NULL];
}


- (Node *)nodeForState:(ListComponentState *)state context:(ComponentContext *)context {
    Node *node = [super nodeForState:state context:context];
    
    NSEnumerationOptions opts = 0;
    const BOOL reversed = state.reversed;
    if (reversed) {
        opts |= NSEnumerationReverse;
    }

    const ComponentSize sizeConstraints = context.size;

    __block CGSize listSize = CGSizeZero;
    __block CGSize childMaxSize = sizeConstraints.max;

    const CGFloat space = state.interItemSpace;
    const ListComponentDirection direction = state.direction;

    NSMutableArray *children = [NSMutableArray array];

    [state.components enumerateObjectsWithOptions:opts
                                       usingBlock:^(Component *_Nonnull component, NSUInteger idx, BOOL *_Nonnull stop) {


                                           switch (direction) {
                                               case ListComponentDirectionHorizontal: {
                                                   if (childMaxSize.width <= space) {
                                                       *stop = YES;
                                                       return;
                                                   }
                                                   break;
                                               }

                                               case ListComponentDirectionVertical: {
                                                   if (childMaxSize.height <= space) {
                                                       *stop = YES;
                                                       return;
                                                   }
                                                   break;
                                               }
                                           }

                                           ComponentContext *childContext = [context copy];
                                           childContext.size = ComponentSizeMaxSize(childMaxSize);

                                           Node *componentNode = [component nodeForContext:childContext];

                                           switch (direction) {
                                               case ListComponentDirectionHorizontal: {
                                                   childMaxSize.width -= space + componentNode.size.width;
                                                   break;
                                               }

                                               case ListComponentDirectionVertical: {
                                                   childMaxSize.height -= space + componentNode.size.height;
                                                   break;
                                               }
                                           }

                                           NodeChild *nodeChild = [NodeChild childWithNode:componentNode];
                                           if (reversed) {
                                               [children insertObject:nodeChild atIndex:0];
                                           } else {
                                               [children addObject:nodeChild];
                                           }

                                       }];


    for (NodeChild *child in children) {
        switch (direction) {
            case ListComponentDirectionHorizontal: {
                if (listSize.width > 0) {
                    listSize.width += space;
                }

                child.origin = CGPointMake(listSize.width, 0);

                listSize.width += child.node.size.width;
                listSize.height = MAX(listSize.height, child.node.size.height);

                break;
            }

            case ListComponentDirectionVertical: {
                if (listSize.height > 0) {
                    listSize.height += space;
                }

                child.origin = CGPointMake(0, listSize.height);

                listSize.height += child.node.size.height;
                listSize.width = MAX(listSize.width, child.node.size.width);
                break;
            }
        }
    }

    const CGSize nodeSize = CGSizeWithConstraints(CGSizeNormalize(listSize), context.size);

    const CGFloat dxTotal = nodeSize.width - listSize.width;
    const CGFloat dyTotal = nodeSize.height - listSize.height;

    const ListComponentHorizontalAlignment hAlign = state.horizontalAlignment;
    const ListComponentVerticalAlignment vAlign = state.verticalAlignment;

    for (NodeChild *child in children) {
        CGPoint origin = child.origin;
        const CGSize childNodeSize = child.node.size;

        switch (direction) {

            case ListComponentDirectionHorizontal:
            {
                switch (hAlign) {

                    case ListComponentHorizontalAlignmentLeft:break;
                    case ListComponentHorizontalAlignmentCenter: origin.x += ceilf(dxTotal/2); break;
                    case ListComponentHorizontalAlignmentRight: origin.x += ceilf(dyTotal); break;
                }

                const CGFloat dy = nodeSize.height - childNodeSize.height;
                switch (vAlign) {

                    case ListComponentVerticalAlignmentTop:break;
                    case ListComponentVerticalAlignmentMiddle: origin.y += ceilf(dy/2); break;
                    case ListComponentVerticalAlignmentBottom: origin.y += dy; break;
                }

                break;
            }



            case ListComponentDirectionVertical:
            {
                const CGFloat dx = nodeSize.width - childNodeSize.width;
                switch (hAlign) {

                    case ListComponentHorizontalAlignmentLeft:break;
                    case ListComponentHorizontalAlignmentCenter: origin.x += ceilf(dx/2); break;
                    case ListComponentHorizontalAlignmentRight: origin.x += ceilf(dx); break;
                }

                switch (vAlign) {

                    case ListComponentVerticalAlignmentTop:break;
                    case ListComponentVerticalAlignmentMiddle: origin.y += ceilf(dyTotal/2); break;
                    case ListComponentVerticalAlignmentBottom: origin.y += dyTotal; break;
                }

                break;
            }
        }

        child.origin = origin;
    }

    node.children = children;
    node.size = nodeSize;
    node.utility = YES;
    
    return node;
}

@end
