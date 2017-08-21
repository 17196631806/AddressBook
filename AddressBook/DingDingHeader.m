//
//  DingDingHeader.m
//  AddressBook
//
//  Created by YaSha_Tom on 2017/8/21.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import "DingDingHeader.h"

@implementation DingDingHeader

+ (DingDingHeader *)shareHelper {
    static DingDingHeader *helper = nil;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        helper = [DingDingHeader new];
        helper.titleList = @[].mutableCopy;
    });
    return helper;
}

@end
