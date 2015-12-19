//
// Created by Alexey Storozhev on 19/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "RootViewController.h"
#import "DemoViewController1.h"
#import "DemoViewController2.h"
#import "DemoViewController3.h"

typedef NS_ENUM(NSInteger, MenuOption) {
    MenuOptionWireframes,
    MenuOptionTextList,
    MenuOptionComplex,

    MenuOptionCount
};

static NSString *NSStringFromMenuOption(MenuOption option) {
    switch (option) {
        case MenuOptionWireframes:
            return @"Wireframes";

        case MenuOptionTextList:
            return @"Text list";

        case MenuOptionComplex:
            return @"Complex";

        case MenuOptionCount:
            return nil;
    }
    return nil;
}

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation RootViewController

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
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MenuOptionCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    cell.textLabel.text = NSStringFromMenuOption((MenuOption)indexPath.row);

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuOption opt = (MenuOption)indexPath.row;

    UIViewController *vc = nil;
    switch (opt) {
        case MenuOptionWireframes:
            vc = [DemoViewController1 new];
            break;

        case MenuOptionTextList:
            vc = [DemoViewController2 new];
            break;

        case MenuOptionComplex:
            vc = [DemoViewController3 new];
            break;

        case MenuOptionCount:
            break;
    }

    if (vc) {
        vc.title = NSStringFromMenuOption(opt);
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
