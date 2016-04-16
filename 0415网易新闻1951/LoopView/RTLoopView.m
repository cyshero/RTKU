//
//  RTLoopView.m
//  0415网易新闻1951
//
//  Created by apple on 16/4/16.
//  Copyright © 2016年 eason. All rights reserved.
//

#import "RTLoopView.h"
#import "RTCollectionViewFlowLayout.h"
#import "RTCollectionViewCell.h"
#import "RTTimer.h"
@interface RTLoopView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)NSArray<NSString*>*urls;
@property(nonatomic,strong)NSArray<NSString*>*titles;
@property(nonatomic,copy)SelectBlock block;
@property(nonatomic,weak)UILabel* label;
@property(nonatomic,weak)UIPageControl* pageControl;
@property(nonatomic,weak)UICollectionView* collectionView;

@property(nonatomic,weak)NSTimer* timer;
@end
@implementation RTLoopView
-(instancetype)initWithUrls:(NSArray<NSString*>*) urls AndTitles:(NSArray<NSString*>*) titles AndDidSelectBlock:(SelectBlock)block{
    if (self=[super init]) {
        // 先把3个参数保存起来
        _urls=urls;
        _titles=titles;
        _block=block;
        //pagecon 的数值必须要在这里设置，因为在这里self的urls才有值
        self.pageControl.numberOfPages=self.urls.count;
        dispatch_async(dispatch_get_main_queue(), ^{
            //默认滚到第一行
            NSIndexPath *path=[NSIndexPath indexPathForItem:self.urls.count inSection:0];
            [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        });
        
        
        [self addTimer];
    }
    return self;
}
/**
 *  @author cys, 16-04-16 11:04:47
 *
 *    重写下面2个方法就是为了在创建对象
 *
 *  @param frame
 *
 *  @return 返回初始化的对象
 */
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setUpLoopView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
         [self setUpLoopView];
    }
    return self;
}
/**
 *  @author cys, 16-04-16 14:04:52
 *
 *   这个方法就非常重要了，在这个方法里面要创建3个控件，colliview ，label，pagecon
 */
-(void)setUpLoopView{
    [self setcollectionView];
    [self setlabelview];
    [self setPageControlview];
}

  //创建UICollectionView
-(void)setcollectionView{
    UICollectionView * collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[RTCollectionViewFlowLayout  new]];
    collectionView.pagingEnabled=YES;
    collectionView.bounces=0;
    collectionView.backgroundColor=[UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator=NO;
    self.collectionView=collectionView;
    [collectionView registerClass:[RTCollectionViewCell class] forCellWithReuseIdentifier:@"LoopView"];
    collectionView.dataSource=self;
    collectionView.delegate=self;
    [self addSubview:collectionView];
}


-(void)setlabelview{
    //创建label
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectZero];
    label.font=[UIFont systemFontOfSize:14];
    label.tintColor=[UIColor blackColor];
    self.label=label;
    [self addSubview:label];
}
-(void)setPageControlview{
    //创建 UIPageControl
    UIPageControl* pageControl=[[UIPageControl alloc]initWithFrame:CGRectZero];
    pageControl.currentPage=0;
    pageControl.hidesForSinglePage=YES;
    pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    pageControl.pageIndicatorTintColor=[UIColor grayColor];
    self.pageControl=pageControl;
    [self addSubview:pageControl];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect rect=self.bounds;
    CGFloat padding=10;
     CGFloat  titleheight=30;
    self.collectionView.frame=CGRectMake(0, 0, rect.size.width, rect.size.height-titleheight);
   
    CGFloat pagew=80;
    CGFloat pageh=titleheight;
    CGFloat pagey=rect.size.height-titleheight;
    CGFloat pagex=rect.size.width-pagew-padding;
    self.pageControl.frame=CGRectMake(pagex, pagey, pagew, pageh);
    
    CGFloat  labelw=rect.size.width-pagew;
    CGFloat   labelh=titleheight;
    CGFloat  labelx=padding;
    CGFloat  labely=rect.size.height-titleheight;
    self.label.frame=CGRectMake(labelx, labely, labelw, labelh);
  
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.urls.count*2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RTCollectionViewCell* cell=[collectionView  dequeueReusableCellWithReuseIdentifier:@"LoopView" forIndexPath:indexPath];
    cell.urlstr=self.urls[indexPath.item%self.urls.count];
    //self.label.text=self.titles[indexPath.item%self.urls.count];
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSUInteger  index=(CGFloat)scrollView.contentOffset.x/self.frame.size.width + 0.5;
    self.pageControl.currentPage=index%self.urls.count;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

//拖动开始销毁定时器
    [self removeTimer];

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

 
    NSUInteger  index=(CGFloat)scrollView.contentOffset.x/self.frame.size.width;
    if (index==0||index==[self.collectionView numberOfItemsInSection:0]-1) {
        CGFloat tmpi=!index?0:1;
        scrollView.contentOffset=CGPointMake((self.urls.count-tmpi)*self.frame.size.width, 0);
    }
    self.label.text=self.titles[index%self.urls.count];
//拖动结束创建定时器
    [self addTimer];
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    [self scrollViewDidEndDecelerating:scrollView];

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.block) {
        self.block(indexPath.item);
    }
}
-(void)addTimer{
    
    if (self.timer) {
        return;
    }
    NSTimer* timer=[[RTTimer new]timerWithTimeInterval:1.5 target:self selector:@selector(nextpage) userInfo:nil repeats:YES];
    self.timer=timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
-(void)removeTimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer=nil;
    }
}

-(void)nextpage{
  
       NSUInteger  index=(CGFloat)self.collectionView.contentOffset.x/self.frame.size.width;
    NSIndexPath* indexpath=[NSIndexPath indexPathForItem:index+1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionLeft animated:1];

}
@end
