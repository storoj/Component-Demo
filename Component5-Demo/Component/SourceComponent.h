//
// Created by Alexey Storozhev on 19/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "Component.h"

typedef NS_ENUM(NSInteger, SourceApplication) {
    SourceApplicationNone,
    SourceApplicationAndroid,
    SourceApplicationIOS,
    SourceApplicationWindows,
    SourceApplicationVKMobile,
    SourceApplicationSnapster,
    SourceApplicationInstagram,
    SourceApplicationCount
};

extern UIImage *SourceApplicationIconImage(SourceApplication app);

@interface Source : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, assign, getter=isPinned) BOOL pinned;
@property (nonatomic, assign, getter=isLocked) BOOL locked;
@property (nonatomic, assign, getter=isRepost) BOOL repost;
@property (nonatomic, assign, getter=isVerified) BOOL verified;
@property (nonatomic, assign) SourceApplication app;
@end

@interface SourceComponent : NSObject

+ (Component *)source:(Source *)source;

@end
