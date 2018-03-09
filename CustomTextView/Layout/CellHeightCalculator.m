//  CellHeightCalculator.m
//  CustomTextView
//
//  Created by NBCB on 2018/3/9.
//  Copyright © 2018年 周清城. All rights reserved.
//

#import "CellHeightCalculator.h"

@interface CellHeightCalculator ()

@property (strong, nonatomic, readonly) NSCache *cache;

@end


@implementation CellHeightCalculator

#pragma mark - Init
- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self defaultConfigure];
    }
    return self;
}

- (void)defaultConfigure {
    
    NSCache *cache = [NSCache new];
    cache.name = @"CellHeightCalculator.cache";
    cache.countLimit = 200;
    _cache = cache;
}

#pragma mark - NSObject

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: cache=%@",
                                      [self class], self.cache];
}

#pragma mark - Publci Methods
- (void)clearCaches
{
    [self.cache removeAllObjects];
}

- (void)setHeight:(CGFloat)height withCalculateheightModel:(NSObject *)model
{
    NSAssert(model != nil, @"Cell Model can't  nil");
    NSAssert(height >= 0, @"cell height must greater than or equal to 0");

    [self.cache setObject:[NSNumber numberWithFloat:height] forKey:@(model.hash)];
}

- (void)setHeight:(CGFloat)height forKey:(NSString *)key {
    
    [self.cache setObject:[NSNumber numberWithFloat:height] forKey:key];
}

- (CGFloat)heightForCalculateheightModel:(NSObject *)model {
    
    NSNumber *cellHeightNumber = [self.cache objectForKey:@(model.hash)];
    
    if (cellHeightNumber) {
        
        CGFloat height = [cellHeightNumber floatValue];
        
        return height > 44 ? height : 44;
    } else
        return -1;
}

- (CGFloat)heightForCalculateHeightKey:(NSString *)key {
    
    NSNumber *cellHeightNumber = [self.cache objectForKey:key];
    
    if (cellHeightNumber) {
        
        CGFloat height = [cellHeightNumber floatValue];
        
        return height > 44 ? height : 44;
    } else
        return -1;
}

@end
