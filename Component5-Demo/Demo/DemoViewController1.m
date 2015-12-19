//
// Created by Alexey Storozhev on 18/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "DemoViewController1.h"
#import "Node.h"
#import "ComponentUtils.h"

static NSArray <NodeChild *> *DemoNodesN(NSUInteger n, CGFloat width) {
    const CGFloat space = 6;
    const CGFloat d = (width-space*n-space) / n;

    NSMutableArray *res = [NSMutableArray array];
    for (NSUInteger i=0; i<n; i++) {
        Node *node = [Node new];
        node.size = CGSizeMake(d, d-space);

        if (d > 20) {
            const NSUInteger childN = arc4random()%n;
            if (childN > 0) {
                node.children = DemoNodesN(childN, d);
            }
        }

        [res addObject:[NodeChild childWithNode:node atPoint:CGPointMake(space + i * (d+space), space)]];
    }
    return [res copy];
}

static NSArray <NodeChild *> *DemoNodes(CGFloat w) {
    return DemoNodesN(4 + arc4random() % 10, w);
}

@interface DemoViewController1()
@property (nonatomic, strong) UIView *host;
@end

@implementation DemoViewController1

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
    host.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:host];

    self.host = host;
}

- (void)viewWillLayoutSubviews {
    self.host.frame = CGRectInset(self.view.bounds, 10, 80);
}

- (void)actionDemo:(id)actionDemo {
    NSArray *nodes = DemoNodes(self.host.bounds.size.width);
    NodeAddToViewDemo1(self.host, nodes);
}

@end
