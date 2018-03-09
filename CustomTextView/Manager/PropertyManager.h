//
//  PropertyManager.h
//  CustomTextView
//
//  Created by NBCB on 2018/3/9.
//  Copyright © 2018年 周清城. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyManager : NSObject

+ (instancetype)sharePropertyManager;

- (UIFont *)getTitleFont;

- (UIFont *)getContentFont;

- (UIFont *)getTimeFont;

@end
