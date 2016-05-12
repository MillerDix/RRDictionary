//
//  MILNetworkManager.h
//  RRDictionary2.0
//
//  Created by MillerD on 3/23/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface MILNetworkManager : AFHTTPSessionManager

+(instancetype)sharedManager;

@end
