//
//  TableViewCell.m
//  CustomTextView
//
//  Created by cc on 2018/1/31.
//  Copyright © 2018年 周清城. All rights reserved.
//

#import "TableViewCell.h"
#import "CustomTextView.h"

typedef void(^RefreshHeightBlock)(NSString *text, CGFloat height);

@interface TableViewCell ()<CustomTextViewDelegate>

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) CustomTextView *textView;
@property (nonatomic, copy) RefreshHeightBlock block;

@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(10);
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(100, 29));
        }];
        
        [self.contentView addSubview:self.textView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UILabel *)label {
    
    if (!_label) {
        
        self.label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor clearColor];
        _label.adjustsFontSizeToFitWidth = YES;
    }
    return _label;
}

- (CustomTextView *)textView {
    
    if (!_textView) {
        
        self.textView = [[CustomTextView alloc] initWithFrame:CGRectMake(115, 7.5, SCREEN_WIDTH - 130, 29)];
        _textView.font = [UIFont systemFontOfSize:17];
        _textView.delegate = self;
        _textView.center = CGPointMake(_textView.center.x, self.center.y);
    }
    return _textView;
}

- (void)refreshCellIndexPath:(NSIndexPath *)idxPath height:(void(^)(NSString *text, CGFloat height))tempBlock {

    if (tempBlock) {
        
        self.textView.tag = idxPath.row;
        self.block = tempBlock;
    }
}

- (void)setModel:(CalculateHeightModel *)model {
    
    _model = model;
    self.label.text = model.title.length > 0 ? model.title : @"- -";
    self.textView.placeholder = model.placeholder.length > 0 ? model.placeholder : @"- -";
}

#pragma mark - CustomTextViewDelegate
- (void)getTextViewText:(NSString *)text height:(CGFloat)height {

    if (self.block) {
        
        self.block(text, height + 15);
    }
}

@end
