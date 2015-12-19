//
//  TextStyle.h
//  VKClient
//
//  Created by Alexey Storozhev on 05/11/15.
//
//

@import Foundation;
@import CoreText;
@import UIKit;

@interface TextStyle : NSObject
@property (nonatomic, strong, readonly) NSDictionary *attributes;
- (instancetype)initWithAttributes:(NSDictionary *)attributes;
+ (instancetype)styleWithAttributes:(NSDictionary *)attributes;

+ (instancetype)defaultStyle;
+ (instancetype)emptyStyle;
@end

@interface TextStyle (Font)
- (UIFont *)font;
- (CGFloat)fontSize;
- (instancetype)withFont:(UIFont *)font;
- (instancetype)withFontSize:(CGFloat)fontSize;
- (instancetype)withFontTraitsAdded:(CTFontSymbolicTraits)traits;
- (instancetype)withFontTraitsRemoved:(CTFontSymbolicTraits)traits;
- (instancetype)withBoldFont;
- (instancetype)withMeduimFont;
@end

@interface TextStyle (Paragraph)
- (instancetype)withLineHeight:(CGFloat)lineHeight;
@end

@interface TextStyle (Color)
- (UIColor *)color;
- (instancetype)withColor:(UIColor *)color;
@end

@interface TextStyle (Style)
- (instancetype)withStyle:(TextStyle *)style;
- (instancetype)withAttributes:(NSDictionary *)attributes;
@end

@interface NSAttributedString (VKTextStyle)
- (instancetype)initWithString:(NSString *)str vkTextStyle:(TextStyle *)style;
+ (instancetype)string:(NSString *)str withVKStyle:(TextStyle *)style;
@end

@interface NSMutableAttributedString (VKTextStyle)
- (void)addVKStyle:(TextStyle *)style range:(NSRange)range;
- (void)setVKStyle:(TextStyle *)style range:(NSRange)range;
@end

@interface NSString (VKTextStyle)
- (NSAttributedString *)attributedStringWithVKStyle:(TextStyle *)style;
@end
