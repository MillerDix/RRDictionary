//
//  NSString+Base64Decode.m
//  RRDictionary2.0
//
//  Created by MillerD on 5/1/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "NSString+Base64Decode.h"

@implementation NSString (Base64Decode)

+(NSString *)base64DecodeToString:(NSString *)string
{
    // initWithBase64方法中，传入的string不能为空，否则报错
    if (string == nil || string.length <= 0) {
        return nil;
    }
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];
    NSString *decodedString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", decodedString);
    return decodedString;
}

@end
