//
// Created by Alexey Storozhev on 17/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "Node.h"

@implementation Node {
    NSMutableDictionary *_userInfoImpl;
}

- (id)objectForKeyedSubscript:(NSString *)key {
    return _userInfoImpl[key];
}

- (void)setObject:(id)object forKeyedSubscript:(NSString *)key {
    if (key) {
        if (!_userInfoImpl) {
            _userInfoImpl = [NSMutableDictionary dictionary];
        }
        _userInfoImpl[key] = object;
    }
}

@end

@implementation NodeChild

- (instancetype)initWithNode:(Node *)node origin:(CGPoint)origin {
    self = [super init];
    if (self) {
        _node = node;
        _origin = origin;
    }
    return self;
}

+ (instancetype)childWithNode:(Node *)node {
    return [self childWithNode:node atPoint:CGPointZero];
}

+ (instancetype)childWithNode:(Node *)node atPoint:(CGPoint)point {
    return [[self alloc] initWithNode:node origin:point];
}

@end
