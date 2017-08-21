//
//  DingDingHeader.h
//  AddressBook
//
//  Created by YaSha_Tom on 2017/8/21.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DingDingHeader : NSObject

@property(nonatomic,strong)NSMutableArray *titleList;//标题数组

+ (DingDingHeader *)shareHelper;

@end
