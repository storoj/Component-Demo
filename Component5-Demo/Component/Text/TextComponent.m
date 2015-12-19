//
// Created by Alexey Storozhev on 17/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "TextComponent.h"
#import "RenderedText.h"

static NSString *const kTextComponentNodeRenderedTextKey = @"RenderedText";

@implementation TextComponentState
@end

@implementation TextComponent
@dynamic state;

+ (instancetype)text:(NSAttributedString *)text {
    return [self text:text numberOfLines:0];
}

+ (instancetype)text:(NSAttributedString *)text numberOfLines:(NSUInteger)numberOfLines {
    TextComponentState *state = [TextComponentState new];
    state.string = text;
    state.numberOfLines = numberOfLines;

    return [[self alloc] initWithState:state];
}


- (__kindof Node *)nodeForState:(TextComponentState *)state context:(ComponentContext *)context {
    Node *node = [super nodeForState:state context:context];

    RenderedText *renderedText = [RenderedText text:state.string
                                              width:context.size.max.width
                                      numberOfLines:state.numberOfLines];

    node.size = CGSizeNormalize(renderedText.size);
    node[kTextComponentNodeRenderedTextKey] = renderedText;

    return node;
}

@end

@implementation TextComponentController
@dynamic view;

+ (__kindof UIView *)createView {
    RenderedTextLabel *label = [RenderedTextLabel new];
    label.backgroundColor = [UIColor clearColor];
    label.userInteractionEnabled = NO;
    return label;
}

- (void)updateWithNode:(Node *)node {
    self.view.text = node[kTextComponentNodeRenderedTextKey];
}

@end
