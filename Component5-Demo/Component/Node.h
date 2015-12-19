//
// Created by Alexey Storozhev on 17/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class NodeChild;

@interface Node : NSObject
@property (nonatomic, strong) NSArray <NodeChild *>* children;
@property (nonatomic, assign) CGSize size;

- (id)objectForKeyedSubscript:(NSString *)key;
- (void)setObject:(id)object forKeyedSubscript:(NSString *)key;
@end

@interface NodeChild : NSObject
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, strong) Node *node;

- (instancetype)initWithNode:(Node *)node origin:(CGPoint)origin;

+ (instancetype)childWithNode:(Node *)node;
+ (instancetype)childWithNode:(Node *)node atPoint:(CGPoint)point;

@end
