//
//  MILNetworkManager.m
//  RRDictionary2.0
//
//  Created by MillerD on 3/23/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "MILNetworkManager.h"

@implementation MILNetworkManager

+(instancetype)sharedManager
{
    static MILNetworkManager *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"http://91dict.com/"];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        configuration.timeoutIntervalForRequest = 30;
        
        instance = [[self alloc] initWithBaseURL:baseURL sessionConfiguration:configuration];
        //instance.requestSerializer = [AFHTTPRequestSerializer serializer];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", nil];

    });
    return instance;
}

@end
