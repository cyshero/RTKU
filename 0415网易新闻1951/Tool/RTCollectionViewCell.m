//
//  RTCollectionViewCell.m
//  0415网易新闻1951
//
//  Created by apple on 16/4/16.
//  Copyright © 2016年 eason. All rights reserved.
//

#import "RTCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface RTCollectionViewCell ()
@property(nonatomic,weak)UIImageView* imageView;
@end
@implementation RTCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
        //创建一个uiiimageview
        UIImageView* imageView=[[UIImageView alloc]init];
        self.imageView=imageView;
        [self addSubview:imageView];
    }

    return self;
}
//在布局的时候设置imageview的值,布满全屏
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame=self.bounds;

}
/**
 *  @author cys, 16-04-16 10:04:35
 *
 *  这个方法是用来设置urlstr的值的，通过设置url的值，顺便设置imageview的值
 *
 *  @param urlstr url的字符串
 */
-(void)setUrlstr:(NSString *)urlstr{
    _urlstr=urlstr;
    NSURL* url=[NSURL URLWithString:urlstr];
    [self.imageView sd_setImageWithURL:url];
}


@end
