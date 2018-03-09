//
//  CalculateHeightModel.h
//  CustomTextView
//
//  Created by NBCB on 2018/3/9.
//  Copyright © 2018年 周清城. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface CalculateHeightModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSNumber *height;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
