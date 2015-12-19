//
// Created by Alexey Storozhev on 19/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "ImageComponent.h"

static NSString *const kImageComponentNodeImageKey = @"Image";

@implementation ImageComponent
@dynamic state;

+ (instancetype)image:(UIImage *)image {
    return [[self alloc] initWithState:image];
}

- (__kindof Node *)nodeForState:(UIImage *)image context:(ComponentContext *)context {
    __kindof Node *node = [super nodeForState:image context:context];
    node.size = CGSizeWithConstraints(image.size, context.size);
    node[kImageComponentNodeImageKey] = image;
    return node;
}

@end

@implementation ImageComponentController
@dynamic view;

+ (__kindof UIView *)createView {
    return [UIImageView new];
}

- (void)updateWithNode:(Node *)node {
    self.view.image = node[kImageComponentNodeImageKey];
}

@end
