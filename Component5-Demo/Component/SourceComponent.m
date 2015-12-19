//
// Created by Alexey Storozhev on 19/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "SourceComponent.h"
#import "ListComponent.h"
#import "TextComponent.h"
#import "TextStyle.h"
#import "StyleSheet.h"
#import "FutureComponent.h"
#import "ImageComponent.h"

UIImage *SourceApplicationIconImage(SourceApplication app) {
    switch (app) {
        case SourceApplicationNone: return nil;
        case SourceApplicationAndroid: return [UIImage imageNamed:@"post_app_android"];
        case SourceApplicationIOS: return [UIImage imageNamed:@"post_app_ios"];
        case SourceApplicationWindows: return [UIImage imageNamed:@"post_app_windows"];
        case SourceApplicationVKMobile: return [UIImage imageNamed:@"post_app_mvk"];
        case SourceApplicationSnapster: return [UIImage imageNamed:@"post_app_snapster"];
        case SourceApplicationInstagram: return [UIImage imageNamed:@"post_app_instagram"];
        case SourceApplicationCount: return nil;
    }

    return nil;
}

@implementation Source
@end

@implementation SourceComponent

+ (Component *)source:(Source *)source {

    return [FutureComponent componentWithContext:^Component *(ComponentContext *futureContext) {
        StyleSheet *sheet = futureContext.styleSheet;
        TextStyleSheet *textStyles = sheet.textStyles;

        Component *nameComponent = [ListComponent build:^(ListComponentBuilderAddComponentBlock addNameItem) {
            addNameItem([TextComponent text:[NSAttributedString string:source.name withVKStyle:textStyles.profileName] numberOfLines:1]);

            if ([source isVerified]) {
                addNameItem([ImageComponent image:[UIImage imageNamed:@"poll_voted_check"]]);
            }

            if ([source isLocked]) {
                addNameItem([ImageComponent image:[UIImage imageNamed:@"card_friends_only"]]);
            }

            if ([source isPinned]) {
                addNameItem([ImageComponent image:[UIImage imageNamed:@"card_pinned"]]);
            }
        } completion:^(ListComponentState *s) {
            s.direction = ListComponentDirectionHorizontal;
            s.verticalAlignment = ListComponentVerticalAlignmentMiddle;
            s.reversed = YES;
            s.interItemSpace = 4.f;
        }];

        nameComponent = [ListComponent build:^(ListComponentBuilderAddComponentBlock addNameItem) {
            if ([source isRepost]) {
                addNameItem([ImageComponent image:[UIImage imageNamed:@"7_repost_icon"]]);
            }

            addNameItem(nameComponent);
        } completion:^(ListComponentState *s) {
            s.direction = ListComponentDirectionHorizontal;
            s.verticalAlignment = ListComponentVerticalAlignmentMiddle;
            s.interItemSpace = 4.f;
        }];

        Component *statusComponent = [ListComponent build:^(ListComponentBuilderAddComponentBlock addStatusItem) {
            addStatusItem([TextComponent text:[NSAttributedString string:source.status withVKStyle:textStyles.subtitle2] numberOfLines:1]);

            UIImage *appIconImage = SourceApplicationIconImage([source app]);
            if (appIconImage ) {
                addStatusItem([ImageComponent image:appIconImage]);
            }

        } completion:^(ListComponentState *s) {
            s.direction = ListComponentDirectionHorizontal;
            s.verticalAlignment = ListComponentVerticalAlignmentMiddle;
            s.reversed = YES;
            s.interItemSpace = 4.f;
        }];

        ListComponent *titlesList = [ListComponent build:^(ListComponentBuilderAddComponentBlock addTitleItem) {
            addTitleItem(nameComponent);
            addTitleItem(statusComponent);
        } completion:^(ListComponentState *s) {
            s.direction = ListComponentDirectionVertical;
            s.verticalAlignment = ListComponentVerticalAlignmentBottom;
            s.interItemSpace = 4.f;
        }];


        return [ListComponent build:^(ListComponentBuilderAddComponentBlock addInfoItem) {
            addInfoItem([ImageComponent image:[UIImage imageNamed:@"7_user_placeholder"]]);
            addInfoItem(titlesList);
        } completion:^(ListComponentState *s) {
            s.direction = ListComponentDirectionHorizontal;
            s.verticalAlignment = ListComponentVerticalAlignmentMiddle;
            s.interItemSpace = 8;
        }];
    }];
    

}

@end
