//  CellHeightCalculator.h
//  CustomTextView
//
//  Created by NBCB on 2018/3/9.
//  Copyright © 2018年 周清城. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CellHeightCalculator : NSObject

//系统计算高度后缓存进cache
- (void)setHeight:(CGFloat)height withCalculateheightModel:(NSObject *)model;

- (void)setHeight:(CGFloat)height forKey:(NSString *)key;

//根据model hash 获取cache中的高度,如过无则返回－1
- (CGFloat)heightForCalculateheightModel:(NSObject *)model;

- (CGFloat)heightForCalculateHeightKey:(NSString *)key;

//清空cache
- (void)clearCaches;

@end
