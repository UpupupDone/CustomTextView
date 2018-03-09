//
//  CustomTextView.m
//  CustomTextView
//
//  Created by cc on 2018/1/31.
//  Copyright © 2018年 周清城. All rights reserved.
//

#import "CustomTextView.h"
#import "InputToolbar.h"
#import "UIView+Extension.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface CustomTextView () {
    
    /** 记录初始化时的height,textview */
    CGFloat             _initHeight;
}

@property (nonatomic, strong) InputToolbar *inputToolbar;
@property (nonatomic, assign) CGFloat inputToolbarY;
@property (nonatomic, strong) UITextView *textView;

/** placeholder的label */
@property (nonatomic, strong) UILabel *placeholderLabel;


@end

@implementation CustomTextView

/** 重写初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // 记录初始高度
        _initHeight = frame.size.height;
        self.clipsToBounds = NO;
        
        // 添加textView
        self.textView = [[UITextView alloc]initWithFrame:self.bounds];
        [self addSubview:self.textView];
        self.textView.delegate = (id)self;
        self.textView.backgroundColor = [UIColor clearColor];
        
        // 添加placeholderLabel
        self.placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(3, 0, frame.size.width - 3, frame.size.height)];
        [self addSubview:self.placeholderLabel];
        self.placeholderLabel.backgroundColor = [UIColor clearColor];
        self.placeholderLabel.textColor = [UIColor lightGrayColor];
        
        [self setTextViewToolbar];
    }
    return self;
}

- (void)setTextViewToolbar {
    
    UIWindow *window =  [[UIApplication sharedApplication].delegate window];
    
    self.inputToolbar = [InputToolbar shareInstance];
    [window addSubview:self.inputToolbar];
    self.inputToolbar.textViewMaxVisibleLine = 4;
    self.inputToolbar.width = window.width;
    self.inputToolbar.height = 49;
    self.inputToolbar.y = window.height - self.inputToolbar.height;
    self.inputToolbar.hidden = YES;
    
    __weak __typeof__ (self) weakSelf = self;
    
    self.inputToolbar.sendContent = ^(NSObject *content) {
        
        NSLog(@"输入文本: ----- %@",(NSString *)content);
        weakSelf.textView.text = (NSString *)content;
        
        weakSelf.inputToolbar.hidden = YES;
        [weakSelf calculatetextViewHeight:weakSelf.textView];
    };
    
    [self.inputToolbar setEditingBlock:^(BOOL isTextLen) {
        
        weakSelf.placeholderLabel.hidden = isTextLen;
    }];
    
    self.inputToolbar.inputToolbarFrameChange = ^(CGFloat height,CGFloat orignY){
        weakSelf.inputToolbarY = orignY;
        /*
         如果是当前界面是tableView可以直接使用以下代码调试位置
         if (weakSelf.tableView.contentSize.height > orignY) {
         [weakSelf.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.bottom.mas_equalTo(0);
         }];
         [weakSelf.tableView setContentOffset:CGPointMake(0, weakSelf.tableView.contentSize.height - orignY) animated:YES];
         }
         */
    };
    [self.inputToolbar resetInputToolbar];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.inputToolbar.isBecomeFirstResponder = NO;
}

- (void)inputToolbar:(InputToolbar *)inputToolbar orignY:(CGFloat)orignY {
    
    _inputToolbarY = orignY;
}

// 赋值font
- (void)setFont:(UIFont *)font {
    
    self.textView.font = self.placeholderLabel.font = font;
}

- (void)setPlaceholder:(NSString *)placeholder {
    
    self.placeholderLabel.text = placeholder;
    
    // 重新调整placeholderLabel的大小
    [self.placeholderLabel sizeToFit];
    
    self.placeholderLabel.center = CGPointMake(self.placeholderLabel.centerX, self.textView.centerY);
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    [textView resignFirstResponder];
    
    self.inputToolbar.hidden = NO;
    self.inputToolbar.isBecomeFirstResponder = YES;
    [self.inputToolbar setHistoryText:self.textView.text];
}

/** textView文本内容改变时回调 */
- (void)calculatetextViewHeight:(UITextView *)textView {
    
    //计算当前textView有多高
    CGFloat height = ceilf([self.textView sizeThatFits:CGSizeMake(self.textView.bounds.size.width, MAXFLOAT)].height);
    NSLog(@"height = %.2f",height);
    
    // 计算最大高度 = (每行高度 * 总行数 + 文字上下间距)
    CGFloat f = ceil([UIFont systemFontOfSize:17].lineHeight * 5 + self.textView.textContainerInset.top + self.textView.textContainerInset.bottom);
    
    __weak __typeof__ (self) weakSelf = self;
    
    __block CGFloat h = 44;
    
    if (height < f) {
        
        self.textView.scrollEnabled = NO;
        
        h = height;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGRect rect = weakSelf.textView.frame;
            rect.size.height = height;
            weakSelf.textView.frame = rect;
        }];
    } else {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.25 animations:^{
                
                weakSelf.textView.scrollEnabled = YES;
                CGRect rect = weakSelf.textView.frame;
                rect.size.height = f;
                weakSelf.textView.frame = rect;
            }];
            
            NSLog(@"textView frame %@", NSStringFromCGRect(weakSelf.textView.frame));
        });
        
        h = f;
    }
    
    if (h < 44) {
        h = 44;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(getTextViewText:height:)]) {
        
        [self.delegate getTextViewText:self.textView.text height:h];
    }
}

@end
