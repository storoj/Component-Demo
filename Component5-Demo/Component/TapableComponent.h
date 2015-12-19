//
// Created by Alexey Storozhev on 18/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "Component.h"

@interface TapableComponent : Component
@property (nonatomic, strong, readonly) Component *component;
@end

@interface TapableComponentController : ComponentController
@end
