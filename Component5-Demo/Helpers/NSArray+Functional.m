//
// Created by Alexey Storozhev on 18/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "NSArray+Functional.h"


@implementation NSArray (Functional)

- (NSArray *)map:(id(^)(id obj))block {
    NSMutableArray *res = [NSMutableArray array];
    for (id obj in self) {
        [res addObject:block(obj)];
    }
    return res;
}

@end
