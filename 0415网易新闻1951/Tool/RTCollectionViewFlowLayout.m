//
//  RTCollectionViewFlowLayout.m
//  0415网易新闻1951
//
//  Created by apple on 16/4/16.
//  Copyright © 2016年 eason. All rights reserved.
//

#import "RTCollectionViewFlowLayout.h"

@implementation RTCollectionViewFlowLayout
//在准备布局的时候会调用

/**
 *  @author cys, 16-04-16 10:04:56
 *
 *  设置布局cell的大小，方向，最小间隔
 */
-(void)prepareLayout{
    self.itemSize=self.collectionView.bounds.size;
    self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    self.minimumInteritemSpacing=0;
    self.minimumLineSpacing=0;
}
@end
