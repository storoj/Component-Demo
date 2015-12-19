//
// Created by Alexey Storozhev on 19/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "DemoViewController3.h"
#import "SourceComponent.h"
#import "StyleSheet.h"
#import "ComponentUtils.h"
#import "ListComponent.h"
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

@interface DemoViewController3()
@property (nonatomic, strong) UIView *host;
@end

@implementation DemoViewController3

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Demo"
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(actionDemo:)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    UIView *host = [[UIView alloc] initWithFrame:CGRectMake(10, 80, 300, 300)];
    host.backgroundColor = [UIColor colorWithWhite:0.4f alpha:1.f];
    [self.view addSubview:host];

    self.host = host;
}

- (void)viewWillLayoutSubviews {
    self.host.frame = CGRectInset(self.view.bounds, 10, 80);
}

- (void)actionDemo:(id)actionDemo {
    ComponentContext *ctx = [ComponentContext new];
    ctx.size = ComponentSizeMaxSize(self.host.bounds.size);
    NSString *applicationContentSizeCategory = [[UIApplication sharedApplication] preferredContentSizeCategory];
    StyleSheetContentSize contentSizeCategory = StyleSheetContentSizeFromUIContentSizeCategory(applicationContentSizeCategory);
    ctx.styleSheet = [StyleSheet darkStyleSheetWithContentSize:contentSizeCategory];

    Component *component = [ListComponent build:^(ListComponentBuilderAddComponentBlock addSource) {
        for (NSUInteger i=0; i<5; i++) {
            addSource([SourceComponent source:RandomSource()]);
        }
    } completion:^(ListComponentState *s) {
        s.direction = ListComponentDirectionVertical;
        s.interItemSpace = 10;
    }];

    Node *node = [component nodeForContext:ctx];
    NodeAddToView(self.host, @[ [NodeChild childWithNode:node] ]);
}

@end
