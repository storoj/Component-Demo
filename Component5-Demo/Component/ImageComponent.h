//
// Created by Alexey Storozhev on 19/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "Component.h"

@interface ImageComponent : Component
@property (nonatomic, strong, readonly) UIImage *state;

+ (instancetype)image:(UIImage *)image;
@end

@interface ImageComponentController : ComponentController
@property (nonatomic, weak) UIImageView *view;
@end
