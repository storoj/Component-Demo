//
// Created by Alexey Storozhev on 17/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "Component.h"
#import "RenderedTextLabel.h"

@interface TextComponentState : NSObject
@property (nonatomic, strong) NSAttributedString *string;
@property (nonatomic, assign) NSUInteger numberOfLines;
@end

@interface TextComponent : Component
@property (nonatomic, strong, readonly) TextComponentState *state;

+ (instancetype)text:(NSAttributedString *)text;
+ (instancetype)text:(NSAttributedString *)text numberOfLines:(NSUInteger)numberOfLines;
@end

@interface TextComponentController : ComponentController
@property (nonatomic, weak) RenderedTextLabel *view;
@end
