//
// Created by Alexey Storozhev on 17/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "Component.h"
#import "UIView+ComponentController.h"
#import "StyleSheet.h"

@implementation ComponentContext

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    ComponentContext *ctx = (ComponentContext *)[[[self class] alloc] init];
    if (ctx) {
        ctx->_size = _size;
        ctx->_styleSheet = _styleSheet;
    }
    return ctx;
}

@end

@implementation Component

+ (void)performBlock:(void (^)(void))block {
    static dispatch_queue_t queue = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("Component", DISPATCH_QUEUE_SERIAL);
    });

    dispatch_async(queue, block);
}

+ (Class)controllerClass {
    Class class = NSClassFromString([NSStringFromClass([self class]) stringByAppendingString:@"Controller"]);
    if (!class) {
        Class superclass = [self superclass];
        if ([superclass isSubclassOfClass:[Component class]]) {
            class = [superclass controllerClass];
        }
    }
    return class;
}

- (instancetype)initWithState:(id)state {
    self = [super init];
    if (self) {
        _state = state;
    }
    return self;
}

- (void)updateState:(ComponentUpdateStateBlock)updateBlock {
    id currentState = self.state;

    [Component performBlock:^{
        id newState = updateBlock(currentState);
        _state = newState;
    }];
}

- (__kindof Node *)nodeForState:(id)state context:(ComponentContext *)context {
    Node *node = [Node new];
    node.size = CGSizeWithConstraints(CGSizeZero, context.size);

    node.component = self;
    node.componentContext = context;

    return node;
}

- (__kindof Node *)nodeForContext:(ComponentContext *)context {
    return [self nodeForState:self.state context:context];
}

@end

@implementation ComponentController

+ (__kindof UIView *)createView {
    return nil;
}

- (instancetype)initWithView:(__kindof UIView *)view {
    self = [super init];
    if (self) {
        _view = view;
        _view._vk_componentController = self;
    }
    return self;
}

- (void)updateWithNode:(Node *)node {}

@end
