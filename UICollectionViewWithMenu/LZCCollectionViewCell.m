//
//  LZCCollectionViewCell.m
//  UICollectionViewWithMenu
//
//  Created by liangfei on 8/10/15.
//  Copyright (c) 2015 liangfeizc. All rights reserved.
//

#import "LZCCollectionViewCell.h"

@interface LZCCollectionViewCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LZCCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    [self.titleLabel setText:title];
}

#pragma mark lazy initialization
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.contentView.frame];
        [_titleLabel setTextColor:[UIColor redColor]];
    }
    return _titleLabel;
}

@end
