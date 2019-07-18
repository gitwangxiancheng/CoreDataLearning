//
//  StudentTableViewCell.m
//  CoreDataLearn
//
//  Created by XianCheng Wang on 2018/7/2.
//  Copyright © 2018年 XianCheng Wang. All rights reserved.
//

#import "StudentTableViewCell.h"

@implementation StudentTableViewCell


-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,80,80)];
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
};
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,10, 200,20)];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
};
-(UILabel *)genderLabel{
    if (!_genderLabel) {
        _genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,30, 200,20)];
        _genderLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_genderLabel];
        
    }
    return _genderLabel;
};
-(UILabel *)ageLabel{
    if (!_ageLabel) {
        _ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,50, 200,20)];
        _ageLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_ageLabel];
        
    }
    return _ageLabel;
};
-(UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,70, 200,20)];
        _numberLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_numberLabel];
    }
    return _numberLabel;
};


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
