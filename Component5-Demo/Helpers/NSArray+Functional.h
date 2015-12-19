//
// Created by Alexey Storozhev on 18/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray <T> (Functional)
- (NSArray *)map:(id(^)(T obj))block;
@end