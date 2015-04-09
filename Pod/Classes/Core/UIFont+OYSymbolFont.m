//
//  Created by CocoaPods on TODAYS_DATE.
//  Copyright (c) 2014 PROJECT_OWNER. All rights reserved.
//

#import "UIFont+OYSymbolFont.h"
@import CoreText;

@interface OYBundleKey : NSObject
@end
@implementation OYBundleKey
@end

NSString *const kOYSymbolFontFamilyName = @"icons";

@implementation UIFont (OYSymbolFont)

+ (instancetype)oy_symbolFontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:kOYSymbolFontFamilyName size:size];
    if (!font) {
        NSBundle* bundle = [NSBundle bundleForClass:[OYBundleKey class]];
        NSString *fontPath = [bundle pathForResource:kOYSymbolFontFamilyName ofType:@"ttf"];
        NSData *inData = [NSData dataWithContentsOfFile:fontPath];
        CFErrorRef error;
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)inData);
        CGFontRef cgFont = CGFontCreateWithDataProvider(provider);
        if (! CTFontManagerRegisterGraphicsFont(cgFont, &error)) {
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            NSLog(@"Failed to load font: %@", errorDescription);
            CFRelease(errorDescription);
        }
        CFRelease(cgFont);
        CFRelease(provider);
        font = [UIFont fontWithName:kOYSymbolFontFamilyName size:size];
    }
    return font;
}

@end
