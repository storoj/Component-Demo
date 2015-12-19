//
// Created by Alexey Storozhev on 18/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "Component.h"

@interface InsetComponentState : NSObject
@property (nonatomic, strong) Component *component;
@property (nonatomic, assign) UIEdgeInsets insets;
@end

@interface InsetComponent : Component
@property (nonatomic, strong, readonly) InsetComponentState *state;
+ (instancetype)component:(Component *)component withInsets:(UIEdgeInsets)insets;
@end
