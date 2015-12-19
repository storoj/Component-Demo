//
// Created by Alexey Storozhev on 18/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "UIView+ComponentController.h"
#import <objc/runtime.h>

static void const *kComponentControllerKey = &kComponentControllerKey;
@implementation UIView (ComponentController)

- (ComponentController *)_vk_componentController {
    return objc_getAssociatedObject(self, kComponentControllerKey);
}

- (void)set_vk_componentController:(ComponentController *)controller{
    objc_setAssociatedObject(self, kComponentControllerKey, controller, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
