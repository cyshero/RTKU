//
//  RTLoopView.h
//  0415网易新闻1951
//
//  Created by apple on 16/4/16.
//  Copyright © 2016年 eason. All rights reserved.
//

#import <UIKit/UIKit.h>
//回调block要把选中图片的索引传递出去
typedef void(^SelectBlock)(NSInteger index);
@interface RTLoopView : UIView
-(instancetype)initWithUrls:(NSArray<NSString*>*) urls AndTitles:(NSArray<NSString*>*) titles AndDidSelectBlock:(SelectBlock)block;
@end
