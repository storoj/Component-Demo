//
// Created by Alexey Storozhev on 17/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef struct {
    CGSize min;
    CGSize max;
} ComponentSize;

extern CGSize CGSizeNormalize(CGSize size);
extern CGSize CGSizeInset(CGSize size, CGFloat dx, CGFloat dy);
extern CGSize CGSizeWithConstraints(CGSize size, ComponentSize constraints);

extern CGPoint CGPointAddPoint(CGPoint p1, CGPoint p2);

extern const CGFloat ComponentDimensionHuge;
extern const ComponentSize ComponentSizeFreeForm;
extern ComponentSize ComponentSizeMaxSize(CGSize maxSize);
extern ComponentSize ComponentSizeMaxWidth(CGFloat width);
