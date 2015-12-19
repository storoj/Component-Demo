//
// Created by Alexey Storozhev on 19/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "FutureComponent.h"


@implementation FutureComponent
@dynamic state;

+ (instancetype)componentWithContext:(Component *(^)(ComponentContext *futureContext))block {
    return [[self alloc] initWithState:block];
}

- (id)componentWithContext:(ComponentContext *)context {
    return self.state(context);
}

- (Node *)nodeForState:(FutureComponentBlock)block context:(ComponentContext *)context {
    Component *component = block(context);
    return [component nodeForContext:context];
}

@end
