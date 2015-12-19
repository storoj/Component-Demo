//
// Created by Alexey Storozhev on 17/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "Component.h"

typedef void(^ListComponentBuilderAddComponentBlock)(Component *);
typedef void(^ListComponentBuilderBlock)(ListComponentBuilderAddComponentBlock);

typedef NS_ENUM(NSInteger, ListComponentDirection) {
    ListComponentDirectionHorizontal,
    ListComponentDirectionVertical
};

typedef NS_ENUM(NSInteger, ListComponentHorizontalAlignment) {
    ListComponentHorizontalAlignmentLeft,
    ListComponentHorizontalAlignmentCenter,
    ListComponentHorizontalAlignmentRight
};

typedef NS_ENUM(NSInteger, ListComponentVerticalAlignment) {
    ListComponentVerticalAlignmentTop,
    ListComponentVerticalAlignmentMiddle,
    ListComponentVerticalAlignmentBottom
};

@interface ListComponentState : NSObject
@property (nonatomic, strong) NSArray <Component *> *components;
@property (nonatomic, assign) ListComponentDirection direction;
@property (nonatomic, assign) ListComponentHorizontalAlignment horizontalAlignment;
@property (nonatomic, assign) ListComponentVerticalAlignment verticalAlignment;
@property (nonatomic, assign) BOOL reversed;
@property (nonatomic, assign) CGFloat interItemSpace;
@end

@interface ListComponent : Component
@property (nonatomic, strong, readonly) ListComponentState *state;
+ (instancetype)list:(ListComponentState *)state;

+ (instancetype)build:(ListComponentBuilderBlock)buildBlock;
+ (instancetype)build:(ListComponentBuilderBlock)buildBlock completion:(void(^)(ListComponentState *s))completion;
@end
