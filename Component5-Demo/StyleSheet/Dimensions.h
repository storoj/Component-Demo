//
//  Dimensions.h
//  VKClient
//
//  Created by Alexey Storozhev on 05/11/15.
//
//

@import CoreGraphics;
@import Foundation;

typedef struct {
    CGFloat sideInset1;
    CGFloat sideInset2;
    
    CGFloat interItemSpace1;
    CGFloat interItemSpace2;
    CGFloat interItemSpace3;
    
    CGFloat profileNameFontSize;
    CGFloat regularTextFontSize;
    CGFloat descriptionFontSize;
    CGFloat chatMessageFontSize;
    
    CGFloat postContentFontSize;
    CGFloat postContentLineHeight;
    
    CGFloat heading1FontSize;
    CGFloat heading2FontSize;
    CGFloat heading3FontSize;
    
    CGFloat subtitle1FontSize;
    CGFloat subtitle2FontSize;
    
} DimensionsTable;


@interface Dimensions : NSObject

- (instancetype)initWithTable:(DimensionsTable)table;
+ (instancetype)dimensionsWithTable:(DimensionsTable)table;

- (instancetype)modifiedDimensions:(DimensionsTable(^)(DimensionsTable table))changeBlock;

#define DIMENSIONS_PROP_DEF(NAME)\
@property (nonatomic, assign, readonly) CGFloat NAME;

DIMENSIONS_PROP_DEF(sideInset1)
DIMENSIONS_PROP_DEF(sideInset2)

DIMENSIONS_PROP_DEF(interItemSpace1)
DIMENSIONS_PROP_DEF(interItemSpace2)
DIMENSIONS_PROP_DEF(interItemSpace3)

DIMENSIONS_PROP_DEF(profileNameFontSize)
DIMENSIONS_PROP_DEF(regularTextFontSize)
DIMENSIONS_PROP_DEF(descriptionFontSize)
DIMENSIONS_PROP_DEF(chatMessageFontSize)

DIMENSIONS_PROP_DEF(postContentFontSize)
DIMENSIONS_PROP_DEF(postContentLineHeight)

DIMENSIONS_PROP_DEF(heading1FontSize)
DIMENSIONS_PROP_DEF(heading2FontSize)
DIMENSIONS_PROP_DEF(heading3FontSize)

DIMENSIONS_PROP_DEF(subtitle1FontSize)
DIMENSIONS_PROP_DEF(subtitle2FontSize)

#undef DIMENSIONS_PROP_DEF

@end
