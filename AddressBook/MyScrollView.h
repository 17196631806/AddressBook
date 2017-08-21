//
//  MyScrollView.h
//  AddressBook
//
//  Created by YaSha_Tom on 2017/8/21.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyScrollView : UIScrollView

@property(nonatomic,strong) NSMutableArray *titleArr;
@property(nonatomic,strong) UIButton *btn;
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,copy) void (^btnClick)(NSString *title , NSInteger tag);

@end
