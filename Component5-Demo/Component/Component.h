//
// Created by Alexey Storozhev on 17/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "Node+Component.h"
#import "ComponentTypes.h"

@class StyleSheet;


@interface ComponentContext : NSObject <NSCopying>
@property (nonatomic, assign) ComponentSize size;
@property (nonatomic, strong) StyleSheet *styleSheet;
@end

typedef id(^ComponentUpdateStateBlock)(id state);

@interface Component : NSObject
@property (nonatomic, strong, readonly) id state;

+ (Class)controllerClass;
+ (void)performBlock:(void(^)(void))block;

- (instancetype)initWithState:(id)state;
- (void)updateState:(ComponentUpdateStateBlock)updateBlock;
- (__kindof Node *)nodeForState:(id)state context:(ComponentContext *)context;
- (__kindof Node *)nodeForContext:(ComponentContext *)context;

@end

@import UIKit;
@interface ComponentController : NSObject
@property (nonatomic, weak) __kindof UIView *view;

+ (__kindof UIView *)createView;
- (instancetype)initWithView:(__kindof UIView *)view;

- (void)updateWithNode:(Node *)node;
@end
