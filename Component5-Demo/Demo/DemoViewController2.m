//
// Created by Alexey Storozhev on 18/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "DemoViewController2.h"
#import "ComponentUtils.h"
#import "NSArray+Functional.h"
#import "TextComponent.h"
#import "InsetComponent.h"
#import "TapableComponent.h"
#import "ListComponent.h"

static NSArray <NSString *> *LoadTexts(void)
{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"texts" ofType:@"json"]];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
}

@interface DemoViewController2() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSString *> *texts;
@property (nonatomic, strong) NSArray <Component *> *components;
@property (nonatomic, strong) NSArray <Node *> *nodes;
@end


@implementation DemoViewController2

- (void)loadView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;

    self.view = tableView;
    self.tableView = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    NSArray <NSString *> *texts = LoadTexts();
    self.components = [texts map:^Component *(NSString *string) {
        TextComponentState *textState = [TextComponentState new];
        textState.string = [[NSAttributedString alloc] initWithString:string attributes:@{
            NSFontAttributeName : [UIFont systemFontOfSize:18],
            NSForegroundColorAttributeName : [UIColor colorWithWhite:0.2f alpha:1.f]
        }];
        textState.numberOfLines = 6;

        Component *component = [[TextComponent alloc] initWithState:textState];

#if (0)
        component = [InsetComponent component:component withInsets:UIEdgeInsetsMake(20,20,20,20)];
#endif
        component = [[TapableComponent alloc] initWithState:component];
        
        return component;
    }];
}

- (void)viewWillLayoutSubviews {
    const CGFloat width = CGRectGetWidth(self.tableView.bounds);
    const ComponentSize sizeConstraints = ComponentSizeMaxWidth(width);

    self.nodes = [self.components map:^id(Component *obj) {
        ComponentContext *ctx = [ComponentContext new];
        ctx.size = sizeConstraints;

        return [obj nodeForContext:ctx];
    }];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.nodes[indexPath.section].size.height;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.nodes count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NodeAddToViewDemo2(cell.contentView, @[ [NodeChild childWithNode:self.nodes[indexPath.section]] ]);
    return cell;
}

@end
