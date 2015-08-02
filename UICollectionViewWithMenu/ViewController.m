//
//  ViewController.m
//  UICollectionViewWithMenu
//
//  Created by liangfei on 7/15/15.
//  Copyright (c) 2015 liangfeizc. All rights reserved.
//

#import "ViewController.h"
#import "OperationBar.h"
#import "Item.h"

#define NUMBER_OF_CELLS_PER_ROW 6
#define CELL_WIDTH 166
#define CELL_HEIGHT 223

@interface ViewController ()

@property (nonatomic, copy) NSMutableArray *dataArray;

@end

@implementation ViewController

- (instancetype)init {
    if (self = [super init]) {
        
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(4, 4, 0, 0);
    layout.minimumInteritemSpacing = 4.f;
    layout.minimumLineSpacing = 4.f;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.collectionView setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:self.collectionView];
}

@end