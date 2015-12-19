//
//  Colors.m
//  VKClient
//
//  Created by Alexey Storozhev on 05/11/15.
//
//

#import "Colors.h"

static inline CGFloat HexColorGetComponent(HexColor color, int component) {
    const int offset = 8 * component;
    return ((color & (0xff << offset)) >> offset) / 255.f;
}

static inline UIColor *UIColorFromHexColor(HexColor hex) {
    return [UIColor colorWithRed:HexColorGetComponent(hex, 2)
                           green:HexColorGetComponent(hex, 1)
                            blue:HexColorGetComponent(hex, 0)
                           alpha:HexColorGetComponent(hex, 3)];
}


@implementation Colors {
    ColorsTable _table;
}

- (instancetype)initWithTable:(ColorsTable)table {
    self = [super init];
    if (self) {
        _table = table;
    }
    return self;
}

+ (instancetype)colorsWithTable:(ColorsTable)table {
    return [(Colors *)[self alloc] initWithTable:table];
}

- (instancetype)modifiedColors:(ColorsTable(^)(ColorsTable table))changeBlock {
    if (changeBlock) {
        return [[self class] colorsWithTable:changeBlock(_table)];
    } else {
        return self;
    }
}

#define COLORS_PROP_IMPL(NAME)\
- (UIColor *)NAME {\
return UIColorFromHexColor(_table.NAME);\
}

COLORS_PROP_IMPL(regularText)
COLORS_PROP_IMPL(link)
COLORS_PROP_IMPL(separator)

COLORS_PROP_IMPL(profileName)

COLORS_PROP_IMPL(heading1)
COLORS_PROP_IMPL(heading2)
COLORS_PROP_IMPL(heading3)

COLORS_PROP_IMPL(subtitle1)
COLORS_PROP_IMPL(subtitle2)

#undef COLORS_PROP_IMPL

@end
