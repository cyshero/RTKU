//
//  RTNetWorkManger.h
//  0415网易新闻1951
//
//  Created by apple on 16/4/15.
//  Copyright © 2016年 eason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>
@interface RTNetWorkManger : AFHTTPSessionManager
+(instancetype)shareManger;
@end
