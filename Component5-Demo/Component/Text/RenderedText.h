//
// Created by Alexey Storozhev on 18/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface RenderedText : NSObject

@property (nonatomic, strong, readonly) NSAttributedString *text;
@property (nonatomic, assign, readonly) CGSize size;
@property (nonatomic, assign, readonly) NSUInteger numberOfLines;
@property (nonatomic, assign, readonly, getter=isTruncated) BOOL truncated;

+ (instancetype)text:(NSAttributedString *)text
               width:(CGFloat)width
       numberOfLines:(NSUInteger)numberOfLines;

- (CFIndex)characterIndexAtPoint:(CGPoint)point;
- (void)drawInContext:(CGContextRef)ctx;

@end
