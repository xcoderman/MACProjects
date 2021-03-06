//
//  CommonFunction.m
//  ToPeso
//
//  Created by pachie on 16/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "CommonFunction.h"
#import <QuartzCore/QuartzCore.h>

@implementation CommonFunction

+ (NSDate *)mfDateFromDotNetJSONString:(NSString *)string
{
    static NSRegularExpression *dateRegEx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateRegEx = [[NSRegularExpression alloc] initWithPattern:@"^\\/date\\((-?\\d++)(?:([+-])(\\d{2})(\\d{2}))?\\)\\/$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    NSTextCheckingResult *regexResult = [dateRegEx firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    if (regexResult) {
        // milliseconds
        NSTimeInterval seconds = [[string substringWithRange:[regexResult rangeAtIndex:1]] doubleValue] / 1000.0;
        // timezone offset
        if ([regexResult rangeAtIndex:2].location != NSNotFound) {
            NSString *sign = [string substringWithRange:[regexResult rangeAtIndex:2]];
            // hours
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:3]]] doubleValue] * 60.0 * 60.0;
            // minutes
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:4]]] doubleValue] * 60.0;
        }
        
                //return [NSDate dateWithTimeIntervalSince1970:seconds];
        return [NSDate dateWithTimeIntervalSince1970:seconds];
    }
    return nil;
}

+ (NSString *)getToPisoInstallURL
{
    return @"https://www.facebook.com/pages/ToPiso/871642766203690";
}

+ (NSString *)getToPisoEmailAddress
{
    return @"topiso101@gmail.com";
}


+ (NSString *)getToPisoFacebookURL
{
    return @"https://www.facebook.com/pages/ToPiso/871642766203690";
}


+ (NSString *)getToPisoTwitterURL
{
    return @"https://twitter.com/topiso101";
}


+(UIImage *)getImageCapture :(UIView *)currentView FrameRect:(CGRect)rect
{
//    //CGRect rect = CGRectMake(50, 50, 300,200);
//
    
    //UIGraphicsBeginImageContext(rect.size);
    
    //CGContextRef context = UIGraphicsGetCurrentContext();
  
    //[currentView.layer renderInContext:context];

    
   // UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(rect.size.width, rect.size.height), currentView.opaque, 0.0);
    

    
    [currentView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
    
   
    //return  image;
}

@end
