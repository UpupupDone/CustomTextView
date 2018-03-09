//
//  CalculateHeightModel.m
//  CustomTextView
//
//  Created by NBCB on 2018/3/9.
//  Copyright © 2018年 周清城. All rights reserved.
//

#import "CalculateHeightModel.h"

@implementation CalculateHeightModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        
        _title = dictionary[@"title"];
        _content = dictionary[@"content"];
        _placeholder = dictionary[@"placeholder"];
        _height = dictionary[@"height"];
    }
    return self;
}

@end
