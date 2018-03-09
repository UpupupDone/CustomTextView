//
//  PropertyManager.m
//  CustomTextView
//
//  Created by NBCB on 2018/3/9.
//  Copyright © 2018年 周清城. All rights reserved.
//

#import "PropertyManager.h"

@implementation PropertyManager

+ (instancetype)sharePropertyManager {
    
    static PropertyManager *propertyManager = nil;
    static dispatch_once_t *oncePredicate;
    
    dispatch_once(oncePredicate, ^{
        
        propertyManager = [[self alloc] init];
    });
    return propertyManager;
}

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
    }
    return self;
}

- (UIFont *)getTitleFont {
    
    return [UIFont boldSystemFontOfSize:18.0];
}

- (UIFont *)getContentFont {
    
    return [UIFont systemFontOfSize:14.0];
}

- (UIFont *)getTimeFont {
    
    return [UIFont systemFontOfSize:13.0];
}

@end

