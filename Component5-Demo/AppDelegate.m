//
//  AppDelegate.m
//  Component5-Demo
//
//  Created by Alexey Storozhev on 17/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[RootViewController new]];
    [window makeKeyAndVisible];
    self.window = window;
    
    return YES;
}

@end
