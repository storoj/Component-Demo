//
// Created by Alexey Storozhev on 18/12/15.
// Copyright (c) 2015 Aleksey Storozhev. All rights reserved.
//

#import "RenderedText.h"
@import CoreText;

@interface RenderedTextLine : NSObject
@property (nonatomic, assign) CTLineRef line;
@property (nonatomic, assign) CGPoint origin;

- (instancetype)initWithLine:(CTLineRef)line origin:(CGPoint)origin;
+ (instancetype)line:(CTLineRef)line origin:(CGPoint)origin;
@end

@implementation RenderedTextLine

- (void)dealloc {
    if (_line) {
        CFRelease(_line);
    }
}

- (instancetype)initWithLine:(CTLineRef)line origin:(CGPoint)origin {
    self = [super init];
    if (self) {
        _line = line;
        _origin = origin;
    }
    return self;
}

+ (instancetype)line:(CTLineRef)line origin:(CGPoint)origin {
    return [[self alloc] initWithLine:line origin:origin];
}


@end

@interface RenderedText ()
@property (nonatomic, strong) NSArray <RenderedTextLine *> *lines;
@end

@implementation RenderedText

+ (instancetype)text:(NSAttributedString *)text
               width:(CGFloat)width
       numberOfLines:(NSUInteger)numberOfLines
{
    CFAttributedStringRef stringRef = (__bridge CFAttributedStringRef)text;
    CTTypesetterRef typeSetter = CTTypesetterCreateWithAttributedString(stringRef);

    NSMutableArray *lines = [NSMutableArray array];

    CFIndex startIdx = 0;
    CFIndex lineIdx = 0;
    const CFIndex len = CFAttributedStringGetLength(stringRef);

    CGSize size = CGSizeZero;

    while (startIdx < len && (numberOfLines == 0 || lineIdx < numberOfLines)) {
        CFIndex lineCharactersCount = CTTypesetterSuggestLineBreak(typeSetter, startIdx, width);


#define TRUNCATION_ENABLED 1

#if (TRUNCATION_ENABLED)

        const CFIndex endIdx = startIdx + lineCharactersCount - 1;
        const BOOL lastLineReached = (numberOfLines > 0 && lineIdx+1 == numberOfLines);
        const BOOL hasMoreText = (endIdx+1 < len);
        const BOOL needsTruncation = (lastLineReached && hasMoreText && [[text string] characterAtIndex:endIdx] != '\n');

        CTLineRef line = NULL;

        if (needsTruncation) {
            const CFIndex extraCharactersCount = 20;
            const CFIndex largerLineLength = MIN(extraCharactersCount, len-(startIdx+lineCharactersCount));

            const CTLineRef largerLine = CTTypesetterCreateLine(typeSetter, CFRangeMake(startIdx, lineCharactersCount+largerLineLength));

            CFDictionaryRef attributes = CFAttributedStringGetAttributes(stringRef, endIdx, NULL);
            CFAttributedStringRef truncationTokenString = CFAttributedStringCreate(kCFAllocatorDefault, CFSTR("\u2026"), attributes);
            CTLineRef truncationToken = CTLineCreateWithAttributedString(truncationTokenString);
            CTLineRef truncatedLine = CTLineCreateTruncatedLine(largerLine, width, kCTLineTruncationEnd, truncationToken);
            CFRelease(truncationToken);
            CFRelease(truncationTokenString);

            CFRelease(largerLine);

            line = truncatedLine;
        } else {
            line = CTTypesetterCreateLine(typeSetter, CFRangeMake(startIdx, lineCharactersCount));
        }
#else
        CTLineRef line = CTTypesetterCreateLine(typeSetter, CFRangeMake(startIdx, lineCharactersCount));
#endif


        CGFloat ascent, descent, leading;
        CGFloat lineWidth = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);

        size.width = MAX(size.width, lineWidth);
        size.height += ascent + descent + leading;

        [lines addObject:[RenderedTextLine line:line origin:CGPointMake(0, size.height-descent-leading)]];

        startIdx+=lineCharactersCount;
        lineIdx++;
    }

    CFRelease(typeSetter);


    RenderedText *r = [[self alloc] init];
    r->_lines = lines;
    r->_size = size;
    r->_text = text;

    return r;
}

- (NSUInteger)numberOfLines {
    return [self.lines count];
}

- (void)drawInContext:(CGContextRef)ctx {
    CGContextSetTextMatrix(ctx, CGAffineTransformMakeScale(1.f, -1.f));

    for (RenderedTextLine *line in self.lines) {
        const CGPoint origin = line.origin;
        CGContextSetTextPosition(ctx, origin.x, origin.y);
        CTLineDraw(line.line, ctx);
    }
}

- (CFIndex)characterIndexAtPoint:(CGPoint)p {
    for (RenderedTextLine *line in self.lines) {
        CGFloat ascent, descent, leading;
        double width = CTLineGetTypographicBounds(line.line, &ascent, &descent, &leading);

        const CGPoint origin = line.origin;

        CGRect lineRect = { origin, CGSizeMake(width, ascent+descent+leading) };
        lineRect = CGRectOffset(lineRect, 0, -ascent);

        if (CGRectContainsPoint(lineRect, p)) {
            CGPoint linePoint = CGPointMake(p.x - origin.x, origin.y - p.y);
            return MAX(0, CTLineGetStringIndexForPosition(line.line, linePoint)-1);
        }
    }
    return NSNotFound;
}

@end
