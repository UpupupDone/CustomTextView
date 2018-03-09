//
//  ViewController.m
//  CustomTextView
//
//  Created by cc on 2018/1/31.
//  Copyright © 2018年 周清城. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "CellHeightCalculator.h"

static NSString *const identifier = @"TableViewCell";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    CellHeightCalculator *_heightCalculator;
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TableViewCell *cell;
@property (nonatomic, strong) __block NSMutableArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self initData];
    
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:identifier];
    self.cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
}

- (void)initData {
    
    _heightCalculator = [[CellHeightCalculator alloc] init];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"地理位置:" forKey:@"title"];
    [dic setObject:@"" forKey:@"content"];
    [dic setObject:@"请输入地址~" forKey:@"placeholder"];
    
    NSNumber *height = [NSNumber numberWithFloat:-1];
    [dic setObject:height forKey:@"height"];
    
    CalculateHeightModel *model = [[CalculateHeightModel alloc] initWithDictionary:dic];
    
    [self.dataArr addObject:model];
}

- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row     = indexPath.row;
    
    NSString *key = [NSString stringWithFormat:@"section%ldrow%ld", section, row];
    
    CalculateHeightModel *model = self.dataArr[section];
    
    CGFloat height = [model.height floatValue];
        
    if (height == -1) {
        
        height = [_heightCalculator heightForCalculateHeightKey:key];
    }
    
    [_heightCalculator setHeight:height forKey:key];
    return height ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark Configure Cell Data
- (void)configureCell:(TableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    __weak __typeof__ (self) weakSelf = self;
    
    [cell refreshCellIndexPath:indexPath height:^(NSString *text, CGFloat height) {
        
        CalculateHeightModel *model = weakSelf.dataArr[0];
        
        [model setContent:text];
        [model setHeight:[NSNumber numberWithFloat:height]];
        [weakSelf.dataArr removeAllObjects];
        [weakSelf.dataArr addObject:model];
        [weakSelf.tableView reloadData];
    }];
}

@end
