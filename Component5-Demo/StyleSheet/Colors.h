//
//  Colors.h
//  VKClient
//
//  Created by Alexey Storozhev on 05/11/15.
//
//

@import UIKit;

typedef uint32_t HexColor;
typedef struct {
    HexColor regularText;
    HexColor link;
    HexColor separator;
    
    HexColor profileName;
    
    HexColor heading1;
    HexColor heading2;
    HexColor heading3;
    
    HexColor subtitle1;
    HexColor subtitle2;
} ColorsTable;


@interface Colors : NSObject

- (instancetype)initWithTable:(ColorsTable)table;
+ (instancetype)colorsWithTable:(ColorsTable)table;

- (instancetype)modifiedColors:(ColorsTable(^)(ColorsTable table))changeBlock;

#define COLORS_PROP_DEF(NAME)\
@property (nonatomic, strong, readonly) UIColor *NAME;

COLORS_PROP_DEF(regularText)
COLORS_PROP_DEF(link)
COLORS_PROP_DEF(separator)

COLORS_PROP_DEF(profileName)

COLORS_PROP_DEF(heading1)
COLORS_PROP_DEF(heading2)
COLORS_PROP_DEF(heading3)

COLORS_PROP_DEF(subtitle1)
COLORS_PROP_DEF(subtitle2)

#undef COLORS_PROP_DEF

@end
