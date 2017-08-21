//
//  MyTableViewCell.m
//  AddressBook
//
//  Created by YaSha_Tom on 2017/8/21.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import "MyTableViewCell.h"
#import <Masonry.h>

@implementation MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgView = [[UIImageView alloc]init];
        self.imgView.layer.masksToBounds = YES;
        self.imgView.layer.cornerRadius = 14;
        [self.contentView addSubview:self.imgView];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_equalTo(self.contentView.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(28, 28));
        }];
        
        
        self.nameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_equalTo(self.imgView.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(100, 25));
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
