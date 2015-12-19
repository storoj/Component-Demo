//
// Created by Alexey Storozhev on 18/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "RenderedTextLabel.h"
#import "RenderedText.h"

@implementation RenderedTextLabel

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self.text drawInContext:UIGraphicsGetCurrentContext()];
}

- (void)setText:(RenderedText *)text {
    _text = text;
    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}

@end
