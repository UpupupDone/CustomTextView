//
//  CollectionViewFlowLayout.m
//  CustomTextView
//
//  Created by NBCB on 2018/2/2.
//  Copyright © 2018年 周清城. All rights reserved.
//

#import "CollectionViewFlowLayout.h"

@implementation CollectionViewFlowLayout

- (void)prepareLayout {
    
    [super prepareLayout];
    CGFloat W = (self.collectionView.bounds.size.width) / 7;
    CGFloat H = (self.collectionView.bounds.size.height) / 3;

    self.itemSize = CGSizeMake(W, H);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    CGFloat Y = (self.collectionView.bounds.size.height - 3 * H);
    self.collectionView.contentInset = UIEdgeInsetsMake(Y, 0, 0, 0);
}

@end
