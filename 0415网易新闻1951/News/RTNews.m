//
//  RTNews.m
//  0415网易新闻1951
//
//  Created by apple on 16/4/16.
//  Copyright © 2016年 eason. All rights reserved.
//

#import "RTNews.h"
#import "RTNetWorkManger.h"
#import <objc/runtime.h>
@implementation RTNews

+(instancetype)CreateNewWithDic:(NSDictionary*)dic{


    return [[self alloc]initWithDic:dic];

}
-(instancetype)initWithDic:(NSDictionary*)dic{

    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
+(NSArray*)NewsWithArray:(NSArray*)array{
    NSMutableArray* destarray=[NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary* dic in array) {
        RTNews* news=[RTNews CreateNewWithDic:dic];
        [destarray addObject:news];
    }
    return destarray;
}

+(void)loadNewWitnSuccessBlock:(void (^)(NSArray* array))successBlock AndFailed:(void(^)(NSError* error))failedBlock{
    NSAssert(successBlock, @"成功回掉代码块不能为空");//http://c.m.163.com/
    
    //应该调用自己的方法生成RTNetWorkManger
   [[RTNetWorkManger shareManger] GET:@"/nc/article/headline/T1348647853363/0-40.html" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
    NSDictionary* dic=responseObject;
    NSString* nextobj=dic.keyEnumerator.nextObject;
    NSArray* array=dic[nextobj];
    NSArray* destarray=[RTNews NewsWithArray:array];
    successBlock(destarray);
} failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
    if (failedBlock) {
        failedBlock(error);
    }
} ];
}


@end
