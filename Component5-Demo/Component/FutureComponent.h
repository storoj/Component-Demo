//
// Created by Alexey Storozhev on 19/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "Component.h"

typedef Component *(^FutureComponentBlock)(ComponentContext *futureContext);

@interface FutureComponent <C: Component *> : Component
@property (nonatomic, strong) FutureComponentBlock state;
+ (instancetype)componentWithContext:(FutureComponentBlock)block;
- (C)componentWithContext:(ComponentContext *)context;
@end
