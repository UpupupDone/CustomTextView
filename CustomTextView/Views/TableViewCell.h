//
//  TableViewCell.h
//  CustomTextView
//
//  Created by cc on 2018/1/31.
//  Copyright © 2018年 周清城. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculateHeightModel.h"

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) CalculateHeightModel *model;

- (void)refreshCellIndexPath:(NSIndexPath *)idxPath height:(void(^)(NSString *text, CGFloat height))tempBlock;

@end
