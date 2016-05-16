//
//  Component5CollectionView.h
//  Component5-Demo
//
//  Created by Alexey Storozhev on 19/04/16.
//  Copyright © 2016 Aleksey Storozhev. All rights reserved.
//

@import UIKit;
#import "Component.h"

@interface Component5CollectionView : UIScrollView <UIScrollViewDelegate>
@property (nonatomic, strong) Component *component;

@property (nonatomic, strong, readonly) Node *currentNode;

- (void)updateNode;
@end
