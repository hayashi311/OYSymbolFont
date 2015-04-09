//
//  Created by CocoaPods on TODAYS_DATE.
//  Copyright (c) 2014 PROJECT_OWNER. All rights reserved.
//

#import "UIImage+OYSymbolFont.h"
#import "UIFont+OYSymbolFont.h"

@implementation UIImage (OYSymbolFont)

+ (instancetype)oy_imageWithSymbolName:(NSString *)symbolName size:(CGFloat)size color:(UIColor *)color {

    UIFont *font = [UIFont oy_symbolFontWithSize:size];

    NSDictionary *attributes = @{
            NSFontAttributeName : font,
            NSForegroundColorAttributeName : color
    };
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:symbolName
                                                                           attributes:attributes];

    CGRect textRect = [attributedString boundingRectWithSize:CGSizeMake(1000, 1000)
                                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                                     context:[NSStringDrawingContext new]];
    textRect.origin = CGPointZero;

    UIGraphicsBeginImageContextWithOptions(textRect.size, NO, 0);

    [attributedString drawInRect:textRect];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return image;
}

+ (instancetype)oy_templateImageWithSymbolName:(NSString *)symbolName size:(CGFloat)size {
    UIImage *image = [self oy_imageWithSymbolName:symbolName size:size color:[UIColor blackColor]];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end