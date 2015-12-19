//
//  TextStyle.m
//  VKClient
//
//  Created by Alexey Storozhev on 05/11/15.
//
//

#import "TextStyle.h"
@import UIKit;

@implementation TextStyle

- (NSString *)description {
    return [[super description] stringByAppendingString:[self.attributes description]];
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        _attributes = attributes ? [attributes copy] : @{};
    }
    return self;
}

+ (instancetype)styleWithAttributes:(NSDictionary *)attributes {
    return [[self alloc] initWithAttributes:attributes];
}

+ (instancetype)defaultStyle {
    return [self styleWithAttributes:@{
                                       NSFontAttributeName : [UIFont systemFontOfSize:[UIFont systemFontSize]],
                                       NSForegroundColorAttributeName : [UIColor blackColor]
                                       }];
}

+ (instancetype)emptyStyle {
    return [self styleWithAttributes:@{}];
}

@end


@implementation TextStyle (Font)

- (UIFont *)font {
    return self.attributes[NSFontAttributeName];
}

- (CGFloat)fontSize {
    UIFont *font = [self font];
    return font ? [font pointSize] : [UIFont systemFontSize];
}

- (instancetype)withFont:(UIFont *)font {
    return [self withAttributes:@{ NSFontAttributeName : font }];
}

- (instancetype)withFontSize:(CGFloat)fontSize {
    return [self withFont:[[self font] fontWithSize:fontSize]];
}

- (instancetype)withFontTraitsAdded:(CTFontSymbolicTraits)traits {
    CTFontRef font = (__bridge CTFontRef)[self font];
    CTFontRef modifiedFont = CTFontCreateCopyWithSymbolicTraits(font, CTFontGetSize(font), NULL, traits, traits);
    return [self withFont:(__bridge_transfer UIFont *)modifiedFont];
}

- (instancetype)withFontTraitsRemoved:(CTFontSymbolicTraits)traits {
    CTFontRef font = (__bridge CTFontRef)[self font];
    CTFontRef modifiedFont = CTFontCreateCopyWithSymbolicTraits(font, CTFontGetSize(font), NULL, 0, traits);
    return [self withFont:(__bridge_transfer UIFont *)modifiedFont];
}

- (instancetype)withBoldFont {
    const CGFloat fontSize = [self fontSize];
    
    UIFont *boldFont = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0f) {
        boldFont = [UIFont fontWithName:@"Helvetica-Bold" size:[self fontSize]];
    } else {
        boldFont = [UIFont boldSystemFontOfSize:fontSize];
    }
    return [self withFont:boldFont];
}

- (instancetype)withMeduimFont {
    const CGFloat fontSize = [self fontSize];

    UIFont *mediumFont = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0f) {
        mediumFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:fontSize];
    } else {

        UIFontDescriptor *descriptor = [[self font] fontDescriptor];
        NSDictionary *attributes = @{
            UIFontDescriptorFamilyAttribute:[descriptor objectForKey:UIFontDescriptorFamilyAttribute] ?: @"Helvetica Neue",
            UIFontDescriptorTraitsAttribute: @{UIFontWeightTrait:@(UIFontWeightMedium)}
        };
        UIFontDescriptor *newDescriptor = [[UIFontDescriptor alloc] initWithFontAttributes:attributes];
        mediumFont = [UIFont fontWithDescriptor:newDescriptor size:17];
    }
    return [self withFont:[mediumFont fontWithSize:fontSize]];
}

@end

@implementation TextStyle (Color)

- (UIColor *)color {
    return self.attributes[NSForegroundColorAttributeName];
}

- (instancetype)withColor:(UIColor *)color {
    return [self withAttributes:@{ NSForegroundColorAttributeName : color }];
}

@end

@implementation TextStyle (Paragraph)

- (instancetype)withLineHeight:(CGFloat)lineHeight {
    NSParagraphStyle *paragraphStyle = self.attributes[NSParagraphStyleAttributeName] ?: [NSParagraphStyle defaultParagraphStyle];
    NSMutableParagraphStyle *mutableParagraphStyle = [paragraphStyle mutableCopy];
    mutableParagraphStyle.minimumLineHeight = lineHeight;
    
    return [self withAttributes:@{ NSParagraphStyleAttributeName : [mutableParagraphStyle copy] }];
}

@end

@implementation TextStyle (Style)

- (instancetype)withStyle:(TextStyle *)style {
    return [self withAttributes:style.attributes];
}

- (instancetype)withAttributes:(NSDictionary *)attributes {
    NSMutableDictionary *resultingAttributes = [self.attributes mutableCopy];
    
    NSMutableDictionary *addedAttributes = [attributes mutableCopy];
    
    {
        NSParagraphStyle *addedParagraphStyle = addedAttributes[NSParagraphStyleAttributeName];
        NSMutableParagraphStyle *currentParagraphStyle = [resultingAttributes[NSParagraphStyleAttributeName] mutableCopy];
        if (addedAttributes && currentParagraphStyle) {
            currentParagraphStyle.lineSpacing = addedParagraphStyle.lineSpacing;
            currentParagraphStyle.minimumLineHeight = addedParagraphStyle.minimumLineHeight;
            currentParagraphStyle.maximumLineHeight = addedParagraphStyle.maximumLineHeight;
        }
        
        [addedAttributes removeObjectForKey:NSParagraphStyleAttributeName];
    }
    
    [resultingAttributes addEntriesFromDictionary:attributes];
    return [[self class] styleWithAttributes:resultingAttributes];
}

@end

@implementation NSAttributedString (VKTextStyle)

+ (instancetype)string:(NSString *)str withVKStyle:(TextStyle *)style {
    return [[self alloc] initWithString:str vkTextStyle:style];
}

- (instancetype)initWithString:(NSString *)str vkTextStyle:(TextStyle *)style {
    if (!str) {
        return nil;
    }
    return [self initWithString:str attributes:[style attributes]];
}

@end

@implementation NSMutableAttributedString (VKTextStyle)

- (void)addVKStyle:(TextStyle *)style range:(NSRange)range {
    [self addAttributes:[style attributes] range:range];
}

- (void)setVKStyle:(TextStyle *)style range:(NSRange)range {
    [self setAttributes:[style attributes] range:range];
}

@end

@implementation NSString (VKTextStyle)

- (NSAttributedString *)attributedStringWithVKStyle:(TextStyle *)style {
    return [NSAttributedString string:self withVKStyle:style];
}

@end
