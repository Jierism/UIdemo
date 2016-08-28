//
//  Hero.h
//  LOL数据模型
//
//  Created by  Jierism on 16/8/27.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hero : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *intro;
@property (nonatomic,strong) NSString *icon;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)heroWithDict:(NSDictionary *)dict;

+ (NSArray *)hero;


@end
