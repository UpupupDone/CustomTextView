//
//  CustomTextView.h
//  CustomTextView
//
//  Created by cc on 2018/1/31.
//  Copyright © 2018年 周清城. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomTextViewDelegate <NSObject>

@required

- (void)getTextViewText:(NSString *)text height:(CGFloat)height;

@end

@interface CustomTextView : UIView

@property (nonatomic, assign) NSUInteger iLimitCount;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, weak) id<CustomTextViewDelegate> delegate;

@end
