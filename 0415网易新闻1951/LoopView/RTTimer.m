//
//  RTTimer.m
//  0415网易新闻1951
//
//  Created by apple on 16/4/16.
//  Copyright © 2016年 eason. All rights reserved.
//

#import "RTTimer.h"
@interface RTTimer ()
@property(nonatomic,weak)id target;
@property(nonatomic,assign)SEL select;
@end
@implementation RTTimer

//这里是偷偷的偷梁换柱，对控制器持有弱引用，然后就避免了定时器对控制器的强引用了
-(NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo{
    self.target=aTarget;
    self.select=aSelector;
    
 NSTimer* timer=   [NSTimer timerWithTimeInterval:ti target:self selector:@selector(star) userInfo:nil repeats:YES];

    return timer;
}
//其实还是调用控制器的方法
-(void)star{
    [self.target performSelector:self.select withObject:nil];
}
@end
