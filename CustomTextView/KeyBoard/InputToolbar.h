//
//  InputToolbar.h
//  CustomTextView
//
//  Created by NBCB on 2018/2/2.
//  Copyright © 2018年 周清城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputToolbar : UIView

+(instancetype) shareInstance;

/**
 *  当前键盘是否可见
 */
@property (nonatomic, assign) BOOL keyboardIsVisiable;

/**
 *  设置第一响应
 */
@property (nonatomic, assign) BOOL isBecomeFirstResponder;

/**
 *  设置输入框最多可见行数
 */
@property (nonatomic, assign) NSInteger textViewMaxVisibleLine;

/**
 *  点击发送后要发送的文本
 */
@property (nonatomic, copy) void(^sendContent)(NSObject *content);

/**
 *  InputToolbar所占高度
 */
@property (nonatomic, copy) void(^inputToolbarFrameChange)(CGFloat height,CGFloat orignY);

/**
 *  实时编辑，监听text的变化
 */
@property (nonatomic, copy) void(^editingBlock)(BOOL isTextLen);

/**
 *  清空inputToolbar内容
 */
- (void)clearInputToolbarContent;

/**
 *  重置inputToolbar
 */
- (void)resetInputToolbar;

/**
 *  记录上次的输入内容
 */
- (void)setHistoryText:(NSString *)text;

@end
