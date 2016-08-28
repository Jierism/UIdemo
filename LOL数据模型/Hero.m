//
//  Hero.m
//  LOL数据模型
//
//  Created by  Jierism on 16/8/27.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "Hero.h"

@implementation Hero

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)heroWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)hero
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"heros.plist" ofType:nil]];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self heroWithDict:dict]];
    }
    
    return arrayM;
}

@end
