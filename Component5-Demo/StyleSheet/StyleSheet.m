//
//  StyleSheet.m
//  VKClient
//
//  Created by Alexey Storozhev on 05/11/15.
//
//

#import "StyleSheet.h"
#import "TextStyle.h"
#import "Colors.h"
#import "Dimensions.h"


StyleSheetContentSize StyleSheetContentSizeFromUIContentSizeCategory(NSString *categoryString) {
#define CASE(C, T) if ([categoryString isEqualToString:C]) return T;
    
    CASE(UIContentSizeCategoryExtraSmall, StyleSheetContentSizeExtraSmall)
    CASE(UIContentSizeCategorySmall, StyleSheetContentSizeSmall)
    CASE(UIContentSizeCategoryMedium, StyleSheetContentSizeMedium)
    CASE(UIContentSizeCategoryLarge, StyleSheetContentSizeLarge)
    CASE(UIContentSizeCategoryExtraLarge, StyleSheetContentSizeExtraLarge)
    CASE(UIContentSizeCategoryExtraExtraLarge, StyleSheetContentSizeExtraExtraLarge)
    CASE(UIContentSizeCategoryExtraExtraExtraLarge, StyleSheetContentSizeExtraExtraExtraLarge)
    
    return StyleSheetContentSizeLarge;
    
#undef CASE
}


static const struct {
    CGFloat profileNameFontSize[StyleSheetContentSizeCount];
    CGFloat regularTextFontSize[StyleSheetContentSizeCount];
    CGFloat descriptionFontSize[StyleSheetContentSizeCount];
    CGFloat chatMessageFontSize[StyleSheetContentSizeCount];
    
    CGFloat heading1FontSize[StyleSheetContentSizeCount];
    CGFloat heading2FontSize[StyleSheetContentSizeCount];
    CGFloat heading3FontSize[StyleSheetContentSizeCount];
    
    CGFloat subtitle1FontSize[StyleSheetContentSizeCount];
    CGFloat subtitle2FontSize[StyleSheetContentSizeCount];
    
    CGFloat postContentFontSize[StyleSheetContentSizeCount];
    CGFloat postContentLineHeight[StyleSheetContentSizeCount];
} StyleSheetDimensions = {
    .regularTextFontSize = { 12, 13, 14, 15, 16, 17, 18 },
    .profileNameFontSize = { 13, 14, 15, 16, 17, 18, 19 },
    .descriptionFontSize = { 10, 11, 12, 13, 14, 15, 16 },
    .chatMessageFontSize = { 13, 14, 15, 16, 17, 18, 19 },

    .heading1FontSize   = { 13, 14, 15, 16, 17, 18, 19 },
    .heading2FontSize   = { 13, 14, 15, 16, 17, 18, 19 },
    .heading3FontSize   = { 13, 14, 15, 16, 17, 18, 19 },
    
    .subtitle1FontSize  = { 11, 12, 13, 14, 15, 16, 17 },
    .subtitle2FontSize  = { 10, 11, 12, 13, 14, 15, 16 },
    
    .postContentFontSize    = { 12, 13, 14, 15, 16, 17, 18 },
    .postContentLineHeight  = { 14, 16, 18, 20, 22, 24, 26 },
};

@implementation StyleSheet

- (instancetype)initWithColors:(Colors *)colors dimensions:(Dimensions *)dimensions {
    return [self initWithColors:colors dimensions:dimensions textStyles:[TextStyleSheet sheetWithColors:colors dimensions:dimensions]];
}

+ (instancetype)sheetWithColors:(Colors *)colors dimensions:(Dimensions *)dimensions {
    return [[self alloc] initWithColors:colors dimensions:dimensions];
}

- (instancetype)initWithColors:(Colors *)colors dimensions:(Dimensions *)dimensions textStyles:(TextStyleSheet *)textStyles {
    self = [super init];
    if (self) {
        _colors = colors;
        _dimensions = dimensions;
        _textStyles = textStyles;
    }
    return self;
}

+ (instancetype)sheetWithColors:(Colors *)colors dimensions:(Dimensions *)dimensions textStyles:(TextStyleSheet *)textStyles {
    return [[self alloc] initWithColors:colors dimensions:dimensions textStyles:textStyles];
}

+ (instancetype)sheetWithContext:(StyleSheetContext)context {
    return [self sheetWithColors:[self colorsWithContext:context]
                      dimensions:[self dimensionsWithContext:context]];
}

+ (instancetype)defaultStyleSheetWithContentSize:(StyleSheetContentSize)contentSize {
    StyleSheetContext context = {
        .contentSize = contentSize,
        .interfaceStyle = InterfaceStyleDefault
    };
    
    return [self sheetWithContext:context];
}

+ (instancetype)darkStyleSheetWithContentSize:(StyleSheetContentSize)contentSize {
    StyleSheetContext context = {
        .contentSize = contentSize,
        .interfaceStyle = InterfaceStyleDark
    };
    
    return [self sheetWithContext:context];
}

- (instancetype)sheetWithTextStyles:(TextStyleSheet *)textStyles {
    return [[self class] sheetWithColors:self.colors dimensions:self.dimensions textStyles:textStyles];
}

+ (Colors *)defaultColors {
    return [Colors colorsWithTable:(ColorsTable){
        .regularText   = 0xff000000,
        .link          = 0xff4774a8,
        .profileName   = 0xff4774a8,
        .heading1      = 0xff393c40,
        .heading2      = 0xff2e3033,
        .heading3      = 0xff78797a,
        .subtitle1     = 0xff393c40,
        .subtitle2     = 0xff909499,
    }];
}

+ (Colors *)darkColors {
    return [Colors colorsWithTable:(ColorsTable){
        .regularText   = 0xffffffff,
        .link          = 0xff4774a8,
        .profileName   = 0xffffffff,
        .heading1      = 0xffffffff,
        .heading2      = 0xffffffff,
        .heading3      = 0xffffffff,
        .subtitle1     = 0xffffffff,
        .subtitle2     = 0xffffffff,
    }];
}

+ (Colors *)colorsWithContext:(StyleSheetContext)context {
    switch (context.interfaceStyle) {
        case InterfaceStyleDefault:
            return [self defaultColors];
            
        case InterfaceStyleDark:
            return [self darkColors];
    }

    return nil;
}

+ (Dimensions *)dimensionsWithContext:(StyleSheetContext)context {
    return [Dimensions dimensionsWithTable:(DimensionsTable){
        .profileNameFontSize = StyleSheetDimensions.profileNameFontSize[context.contentSize],
        .regularTextFontSize = StyleSheetDimensions.regularTextFontSize[context.contentSize],
        .descriptionFontSize = StyleSheetDimensions.descriptionFontSize[context.contentSize],
        .chatMessageFontSize = StyleSheetDimensions.chatMessageFontSize[context.contentSize],
        
        .heading1FontSize = StyleSheetDimensions.heading1FontSize[context.contentSize],
        .heading2FontSize = StyleSheetDimensions.heading2FontSize[context.contentSize],
        .heading3FontSize = StyleSheetDimensions.heading3FontSize[context.contentSize],
        
        .subtitle1FontSize = StyleSheetDimensions.subtitle1FontSize[context.contentSize],
        .subtitle2FontSize = StyleSheetDimensions.subtitle2FontSize[context.contentSize],
        
        .postContentFontSize = StyleSheetDimensions.postContentFontSize[context.contentSize],
        .postContentLineHeight = StyleSheetDimensions.postContentLineHeight[context.contentSize],
        
        .interItemSpace1 = 12,
        .interItemSpace2 = 8,
        .interItemSpace3 = 4,
        
        .sideInset1 = 12,
        .sideInset2 = 8,
    }];
}

+ (TextStyleSheet *)textStylesWithContext:(StyleSheetContext)context {
    return [TextStyleSheet sheetWithColors:[self colorsWithContext:context]
                                dimensions:[self dimensionsWithContext:context]];
}

@end



@interface TextStyleSheet()
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

@implementation TextStyleSheet

- (instancetype)initWithColors:(Colors *)colors dimensions:(Dimensions *)dimensions {
    self = [super init];
    if (self) {
        _colors = colors;
        _dimensions = dimensions;
        
        _heading1 = [[[TextStyle defaultStyle] withFontSize:dimensions.heading1FontSize] withColor:colors.heading1];
        _heading2 = [[[TextStyle defaultStyle] withFontSize:dimensions.heading2FontSize] withColor:colors.heading2];
        _heading3 = [[[TextStyle defaultStyle] withFontSize:dimensions.heading3FontSize] withColor:colors.heading3];
        
        _subtitle1 = [[[TextStyle defaultStyle] withFontSize:dimensions.subtitle1FontSize] withColor:colors.subtitle1];
        _subtitle2 = [[[TextStyle defaultStyle] withFontSize:dimensions.subtitle2FontSize] withColor:colors.subtitle2];

        _regularText = [[[TextStyle defaultStyle] withFontSize:dimensions.regularTextFontSize] withColor:colors.regularText];
        _postContent = [[_regularText withFontSize:dimensions.postContentFontSize] withLineHeight:dimensions.postContentLineHeight];
        _chatMessage = [_regularText withFontSize:dimensions.chatMessageFontSize];
        _profileName = [[[[TextStyle defaultStyle] withFontSize:dimensions.profileNameFontSize] withMeduimFont] withColor:colors.profileName];
        _link = [[TextStyle emptyStyle] withColor:colors.link];
    }
    return self;
}

+ (instancetype)sheetWithColors:(Colors *)colors dimensions:(Dimensions *)dimensions {
    return [[self alloc] initWithColors:colors dimensions:dimensions];
}

- (instancetype)initWithStyleSheet:(TextStyleSheet *)styleSheet {
    self = [super init];
    if (self) {
        _colors = styleSheet.colors;
        _dimensions = styleSheet.dimensions;
        
        _heading1 = styleSheet.heading1;
        _heading2 = styleSheet.heading2;
        _heading3 = styleSheet.heading3;
        
        _subtitle1 = styleSheet.subtitle1;
        _subtitle2 = styleSheet.subtitle2;
        
        _regularText = styleSheet.regularText;
        _chatMessage = styleSheet.chatMessage;
        _profileName = styleSheet.profileName;
        
        _link = styleSheet.link;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[TextStyleSheet alloc] initWithStyleSheet:self];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [[TextStyleSheetMutable alloc] initWithStyleSheet:self];
}

@end


@implementation TextStyleSheetMutable

@dynamic heading1;
@dynamic heading2;
@dynamic heading3;

@dynamic subtitle1;
@dynamic subtitle2;

@dynamic regularText;
@dynamic postContent;
@dynamic chatMessage;
@dynamic profileName;

@dynamic link;


@end
