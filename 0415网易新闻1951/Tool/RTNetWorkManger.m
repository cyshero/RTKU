//
//  RTNetWorkManger.m
//  0415网易新闻1951
//
//  Created by apple on 16/4/15.
//  Copyright © 2016年 eason. All rights reserved.
//

#import "RTNetWorkManger.h"

@implementation RTNetWorkManger
+(instancetype)shareManger{
    //其实主要是调用initwithbaseurl，再改变manger的接收类型
    static RTNetWorkManger* manger=nil;
   static  dispatch_once_t  once;
    dispatch_once(&once, ^{
        NSURL* url=[NSURL URLWithString:@"http://c.m.163.com/nc/ad/"];
        manger=[[self alloc]initWithBaseURL:url];
        manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return manger;
}
@end
