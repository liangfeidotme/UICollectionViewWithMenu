//
//  OperationBar.m
//  UICollectionViewWithMenu
//
//  Created by liangfei on 7/30/15.
//  Copyright (c) 2015 liangfeizc. All rights reserved.
//

#import "OperationBar.h"

@interface OperationBar()

@property(nonatomic, strong) UIButton *editButton;

@end

@implementation OperationBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _editButton.backgroundColor = [UIColor greenColor];
        _editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        
        [self addSubview:_editButton];
    }
    
    return self;
}

@end
