//
//  ViewController.m
//  UICollectionViewWithMenu
//
//  Created by liangfei on 7/15/15.
//  Copyright (c) 2015 liangfeizc. All rights reserved.
//

#import "ViewController.h"
#import "LZCCollectionViewCell.h"
#import "LZCCollectionViewMenuCell.h"

#define NUMBER_OF_CELLS_PER_ROW 6
#define CELL_WIDTH 50
#define CELL_HEIGHT 50

#define kCellIdentifier @"cellIdentifier"
#define kMenuCellIdentifier @"menuCellIdentifier"

@interface ViewController ()

@property (nonatomic, copy) NSMutableArray *dataSource;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (instancetype)init {
    self = [super init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}

#pragma mark lazy initialization

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 5; i++) {
            NSArray *sectionData = [[NSArray alloc] initWithObjects:@"This", @"is", @"my", @"first", @"iOS", @"project", nil];
            [_dataSource addObject:sectionData];
        }
    }
    return _dataSource;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsZero;
        layout.minimumInteritemSpacing = 4.f;
        layout.minimumLineSpacing = 4.f;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [self.collectionView registerClass:[LZCCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
        [self.collectionView registerClass:[LZCCollectionViewMenuCell class] forCellWithReuseIdentifier:kMenuCellIdentifier];
        [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    }
    
    return _collectionView;
}


#pragma mark implementations for data source protocol

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.dataSource objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.dataSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LZCCollectionViewCell *cell = (LZCCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    NSString *title = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.title = title;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CELL_WIDTH, CELL_HEIGHT);
}

@end