//
//  MyScrollView.m
//  AddressBook
//
//  Created by YaSha_Tom on 2017/8/21.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import "MyScrollView.h"
#import "UIView+Utils.h"

@implementation MyScrollView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setTitleArr:(NSMutableArray *)titleArr {
    [self creatBtn:titleArr];
}
    
- (void)creatBtn:(NSMutableArray *)arr {
    UIButton *btn;
    //保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat w = 0;
    for (int i = 0; i < arr.count; i++) {
        btn = [[UIButton alloc]init];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        //自适应宽度
        NSDictionary *attributs = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
        CGFloat length = [arr[i] boundingRectWithSize:CGSizeMake(20000, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributs context:nil].size.width;
        btn.frame = CGRectMake(15+w, 15, length, 30);
        NSString *title = [arr objectAtIndex:i];
        btn.tag = i;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        w = btn.frame.size.width +btn.frame.origin.x+20;
        [self addSubview:btn];
        self.btn = btn;
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(btn.right+10, 23, 10, 15)];
        self.imgView.image = [UIImage imageNamed:@"选择"];
        [self addSubview:self.imgView];
        if (i == arr.count - 1) {
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            btn.enabled = NO;
            self.imgView.hidden = YES;
        }else{
            [btn setTitleColor:[UIColor colorWithRed:42.0/255.0 green:138.0/255.0 blue:229.0/255.0 alpha:1.0]forState:UIControlStateNormal];
            btn.enabled = YES;
        }
    }
    
    self.contentSize = CGSizeMake(btn.frame.origin.x+60, 60);
    [self scrollRectToVisible:btn.frame animated:YES];
}

- (void)btn:(UIButton *)sender {
    NSString *title = sender.titleLabel.text;
    NSInteger tag = sender.tag;
    if (self.btnClick) {
        self.btnClick(title, tag);
    }
}

@end
