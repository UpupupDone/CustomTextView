//
//  IMEmotionEntity.h
//  CustomTextView
//
//  Created by NBCB on 2018/2/2.
//  Copyright © 2018年 周清城. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMEmotionEntity : NSObject

+ (IMEmotionEntity *)entityWithDictionary:(NSDictionary*)dic atIndex:(int)index;

@property (nonatomic, copy) NSString* code;//for post, ex:[0]
@property (nonatomic, copy) NSString* name;//for parse, ex:[微笑]
@property (nonatomic, copy) NSString* imageName;//ex, Expression_1.png

@end

