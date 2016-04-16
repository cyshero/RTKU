//
//  RTNews.h
//  0415网易新闻1951
//
//  Created by apple on 16/4/16.
//  Copyright © 2016年 eason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTNews : NSObject
//标题
@property(nonatomic,copy)NSString* title;
//副标题
@property(nonatomic,copy)NSString* digest;
//图片src
@property(nonatomic,copy)NSString* imagesrc;
//跟帖数
@property(nonatomic,strong)NSNumber* replyCount;
//多图数组
@property(nonatomic,strong)NSArray*  imgextra;
//大图标识
@property(nonatomic,assign)BOOL   imgType;

+(instancetype)CreateNewWithDic:(NSDictionary*)dic;
-(instancetype)initWithDic:(NSDictionary*)dic;
+(NSArray*)NewsWithArray:(NSArray*)array;

+(void)loadNewWitnSuccessBlock:(void (^)(NSArray* array))successBlock AndFailed:(void(^)(NSError* error))failedBlock;
@end
