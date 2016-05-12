//
//  MILWords.m
//  RRDictionary2.0
//
//  Created by MillerD on 3/24/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "MILWords.h"

@interface MILWords () <NSCoding>

@end

@implementation MILWords

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.subimg = [aDecoder decodeObjectForKey:@"subimg"];
        self.suben = [aDecoder decodeObjectForKey:@"suben"];
        self.subcn = [aDecoder decodeObjectForKey:@"subcn"];
        self.keyword = [aDecoder decodeObjectForKey:@"keyword"];
        self.yinbiao = [aDecoder decodeObjectForKey:@"yinbiao"];
        self.explain = [aDecoder decodeObjectForKey:@"explain"];
        self.subaudio = [aDecoder decodeObjectForKey:@"subaudio"];
        self.subid = [aDecoder decodeObjectForKey:@"subid"];
        self.filmname = [aDecoder decodeObjectForKey:@"filmname"];
        self.filmid = [aDecoder decodeObjectForKey:@"filmid"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.subimg forKey:@"subimg"];
    [aCoder encodeObject:self.suben forKey:@"suben"];
    [aCoder encodeObject:self.subcn forKey:@"subcn"];
    [aCoder encodeObject:self.keyword forKey:@"keyword"];
    [aCoder encodeObject:self.yinbiao forKey:@"yinbiao"];
    [aCoder encodeObject:self.explain forKey:@"explain"];
    [aCoder encodeObject:self.subaudio forKey:@"subaudio"];
    [aCoder encodeObject:self.subid forKey:@"subid"];
    [aCoder encodeObject:self.filmname forKey:@"filmname"];
    [aCoder encodeObject:self.filmid forKey:@"filmid"];
    
}

@end
