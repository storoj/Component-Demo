//
//  StyleSheet.h
//  VKClient
//
//  Created by Alexey Storozhev on 05/11/15.
//
//

@import Foundation;

@class TextStyle;
@class Colors;
@class Dimensions;

@interface TextStyleSheet : NSObject <NSCopying, NSMutableCopying>

@property (nonatomic, strong, readonly) Colors *colors;
@property (nonatomic, strong, readonly) Dimensions *dimensions;

@property (nonatomic, strong, readonly) TextStyle *heading1;
@property (nonatomic, strong, readonly) TextStyle *heading2;
@property (nonatomic, strong, readonly) TextStyle *heading3;

@property (nonatomic, strong, readonly) TextStyle *subtitle1;
@property (nonatomic, strong, readonly) TextStyle *subtitle2;

@property (nonatomic, strong, readonly) TextStyle *regularText;
@property (nonatomic, strong, readonly) TextStyle *postContent;
@property (nonatomic, strong, readonly) TextStyle *chatMessage;
@property (nonatomic, strong, readonly) TextStyle *profileName;

@property (nonatomic, strong, readonly) TextStyle *link;

- (instancetype)initWithStyleSheet:(TextStyleSheet *)styleSheet;
- (instancetype)initWithColors:(Colors *)colors dimensions:(Dimensions *)dimensions;
+ (instancetype)sheetWithColors:(Colors *)colors dimensions:(Dimensions *)dimensions;

@end

@interface TextStyleSheetMutable : TextStyleSheet
@property (nonatomic, strong) TextStyle *heading1;
@property (nonatomic, strong) TextStyle *heading2;
@property (nonatomic, strong) TextStyle *heading3;

@property (nonatomic, strong) TextStyle *subtitle1;
@property (nonatomic, strong) TextStyle *subtitle2;

@property (nonatomic, strong) TextStyle *regularText;
@property (nonatomic, strong) TextStyle *postContent;
@property (nonatomic, strong) TextStyle *chatMessage;
@property (nonatomic, strong) TextStyle *profileName;

@property (nonatomic, strong) TextStyle *link;
@end

typedef NS_ENUM(NSInteger, StyleSheetContentSize) {
    StyleSheetContentSizeExtraSmall,
    StyleSheetContentSizeSmall,
    StyleSheetContentSizeMedium,
    StyleSheetContentSizeLarge,
    StyleSheetContentSizeExtraLarge,
    StyleSheetContentSizeExtraExtraLarge,
    StyleSheetContentSizeExtraExtraExtraLarge,
    
    StyleSheetContentSizeCount
};

extern StyleSheetContentSize StyleSheetContentSizeFromUIContentSizeCategory(NSString *categoryString);

typedef NS_ENUM(NSInteger, InterfaceStyle) {
    InterfaceStyleDefault,
    InterfaceStyleDark
};

typedef struct {
    StyleSheetContentSize contentSize;
    InterfaceStyle interfaceStyle;
} StyleSheetContext;

@interface StyleSheet : NSObject
@property (nonatomic, strong, readonly) Colors *colors;
@property (nonatomic, strong, readonly) Dimensions *dimensions;
@property (nonatomic, strong, readonly) TextStyleSheet *textStyles;

- (instancetype)initWithColors:(Colors *)colors dimensions:(Dimensions *)dimensions;
+ (instancetype)sheetWithColors:(Colors *)colors dimensions:(Dimensions *)dimensions;

- (instancetype)initWithColors:(Colors *)colors dimensions:(Dimensions *)dimensions textStyles:(TextStyleSheet *)textStyles;
+ (instancetype)sheetWithColors:(Colors *)colors dimensions:(Dimensions *)dimensions textStyles:(TextStyleSheet *)textStyles;

+ (instancetype)sheetWithContext:(StyleSheetContext)context;

+ (instancetype)defaultStyleSheetWithContentSize:(StyleSheetContentSize)contentSize;
+ (instancetype)darkStyleSheetWithContentSize:(StyleSheetContentSize)contentSize;

- (instancetype)sheetWithTextStyles:(TextStyleSheet *)textStyles;

+ (Colors *)colorsWithContext:(StyleSheetContext)context;
+ (Dimensions *)dimensionsWithContext:(StyleSheetContext)context;
+ (TextStyleSheet *)textStylesWithContext:(StyleSheetContext)context;

@end

