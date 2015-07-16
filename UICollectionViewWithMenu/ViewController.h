//
//  ViewController.h
//  UICollectionViewWithMenu
//
//  Created by liangfei on 7/15/15.
//  Copyright (c) 2015 liangfeizc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

