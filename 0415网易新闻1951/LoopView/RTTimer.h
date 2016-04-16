//
//  RTTimer.h
//  0415网易新闻1951
//
//  Created by apple on 16/4/16.
//  Copyright © 2016年 eason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTTimer : NSObject
/**
 *  @author cys, 16-04-16 10:04:18
 *
 *  这个方法是用来解决定时器强引用控制器，导致控制器无法销毁的问题
 *
 *  @param ti        <#ti description#>
 *  @param aTarget   <#aTarget description#>
 *  @param aSelector <#aSelector description#>
 *  @param userInfo  <#userInfo description#>
 *  @param yesOrNo   <#yesOrNo description#>
 *
 *  @return 返回一个定时器以便控制器调用
 */
-(NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
@end
