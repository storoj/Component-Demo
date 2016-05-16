//
//  DemoViewController4.m
//  Component5-Demo
//
//  Created by Alexey Storozhev on 19/04/16.
//  Copyright © 2016 Aleksey Storozhev. All rights reserved.
//

#import "DemoViewController4.h"
#import "Component5CollectionView.h"
#import "ListComponent.h"
#import "SourceComponent.h"
#import "InsetComponent.h"

static NSString *RandomName() {
    static NSArray *names = nil;
    if (!names) {
        names = @[
                  @"Alexey Storozhev",
                  @"Andrey Rogozov",
                  @"Pavel Durov"
                  ];
    }
    
    return names[arc4random()%names.count];
}

static NSString *RandomStatus() {
    static NSArray *statuses = nil;
    if (!statuses) {
        statuses = @[
                     @"just now",
                     @"5 minutes ago",
                     @"an hour ago",
                     @"three days ago",
                     @"yesterday"
                     ];
    }
    
    return statuses[arc4random()% statuses.count];
}

static Source *RandomSource() {
    
    Source *source = [Source new];
    source.name = RandomName();
    source.status = RandomStatus();
    source.locked = arc4random()%100 < 50;
    source.pinned = arc4random()%100 < 50;
    source.repost = arc4random()%100 < 50;
    source.verified = arc4random()%100 < 50;
    source.app = (SourceApplication)(arc4random()%SourceApplicationCount);
    
    return source;
}

@interface DemoViewController4()
@property (nonatomic, strong) Component5CollectionView *collectionView;
@end

@implementation DemoViewController4

- (void)loadView {
    Component5CollectionView *collectionView = [[Component5CollectionView alloc] initWithFrame:CGRectZero];
    self.view = collectionView;
    self.collectionView = collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.component = [self makeComponent];
    [self.collectionView updateNode];
}

- (Component *)makeComponent {
    Component *component = [ListComponent build:^(ListComponentBuilderAddComponentBlock addSource) {
        for (NSUInteger i=0; i<50; i++) {
            addSource([SourceComponent source:RandomSource()]);
        }
    } completion:^(ListComponentState *s) {
        s.direction = ListComponentDirectionVertical;
        s.interItemSpace = 10;
    }];

    return component;
}

@end
