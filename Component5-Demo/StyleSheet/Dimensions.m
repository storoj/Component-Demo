//
//  Dimensions.m
//  VKClient
//
//  Created by Alexey Storozhev on 05/11/15.
//
//

#import "Dimensions.h"

@implementation Dimensions {
    DimensionsTable _table;
}

- (instancetype)initWithTable:(DimensionsTable)table {
    self = [super init];
    if (self) {
        _table = table;
    }
    return self;
}

+ (instancetype)dimensionsWithTable:(DimensionsTable)table {
    return [(Dimensions *)[self alloc] initWithTable:table];
}

- (instancetype)modifiedDimensions:(DimensionsTable(^)(DimensionsTable data))changeBlock {
    if (changeBlock) {
        return [[self class] dimensionsWithTable:changeBlock(_table)];
    } else {
        return self;
    }
}

#define DIMENSIONS_PROP_IMPL(NAME)\
- (CGFloat)NAME {\
return _table.NAME;\
}

DIMENSIONS_PROP_IMPL(sideInset1)
DIMENSIONS_PROP_IMPL(sideInset2)

DIMENSIONS_PROP_IMPL(interItemSpace1)
DIMENSIONS_PROP_IMPL(interItemSpace2)
DIMENSIONS_PROP_IMPL(interItemSpace3)

DIMENSIONS_PROP_IMPL(regularTextFontSize)
DIMENSIONS_PROP_IMPL(profileNameFontSize)

DIMENSIONS_PROP_IMPL(descriptionFontSize)
DIMENSIONS_PROP_IMPL(chatMessageFontSize)

DIMENSIONS_PROP_IMPL(postContentFontSize)
DIMENSIONS_PROP_IMPL(postContentLineHeight)

DIMENSIONS_PROP_IMPL(heading1FontSize)
DIMENSIONS_PROP_IMPL(heading2FontSize)
DIMENSIONS_PROP_IMPL(heading3FontSize)

DIMENSIONS_PROP_IMPL(subtitle1FontSize)
DIMENSIONS_PROP_IMPL(subtitle2FontSize)

#undef DIMENSIONS_PROP_IMPL

@end
