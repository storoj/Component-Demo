//
// Created by Alexey Storozhev on 17/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "ComponentTypes.h"

CGSize CGSizeNormalize(CGSize size) {
    return (CGSize){
        .width = ceilf(size.width),
        .height = ceilf(size.height)
    };
}

CGSize CGSizeInset(CGSize size, CGFloat dx, CGFloat dy) {
    return (CGSize){
        .width = MAX(0, size.width - dx),
        .height = MAX(0, size.height - dy)
    };
}

CGSize CGSizeWithConstraints(CGSize size, ComponentSize constraints) {
    return CGSizeNormalize((CGSize){
        .width = MAX(constraints.min.width, MIN(constraints.max.width, size.width)),
        .height = MAX(constraints.min.height, MIN(constraints.max.height, size.height))
    });
}


CGPoint CGPointAddPoint(CGPoint p1, CGPoint p2) {
    return (CGPoint){
        p1.x + p2.x,
        p1.y + p2.y
    };
}


const CGFloat ComponentDimensionHuge = 10e5;
const ComponentSize ComponentSizeFreeForm = {
    .min = { .width = 0.f, .height = 0.f },
    .max = { .width = ComponentDimensionHuge, .height = ComponentDimensionHuge }
};

ComponentSize ComponentSizeMaxSize(CGSize maxSize) {
    return (ComponentSize){
        .min = CGSizeZero,
        .max = maxSize
    };
}

ComponentSize ComponentSizeMaxWidth(CGFloat width) {
    return ComponentSizeMaxSize(CGSizeMake(width, ComponentDimensionHuge));
}
