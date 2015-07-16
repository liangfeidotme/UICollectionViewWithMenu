//
//  ViewController.m
//  UICollectionViewWithMenu
//
//  Created by liangfei on 7/15/15.
//  Copyright (c) 2015 liangfeizc. All rights reserved.
//

#import "ViewController.h"

#define NUMBER_OF_CELLS_PER_ROW 6

@interface ViewController ()

@property (nonatomic, copy) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger sectionOfMenuCell;
@property (nonatomic, assign) NSInteger rowOfMenuCell;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // create parent view
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // create an UICollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.collectionView setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:self.collectionView];
    
    [self setMenuCellSection:-1 row:-1];
    
    // initialize data array with mock data
    _dataArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    for (int i = 0; i < 5; i++) {
        NSArray *sectionDataArray = [[NSArray alloc] initWithObjects:@"Hello", @"World", @"I", @"Love",
                                     @"Android", @"iOS", @"Than", @"iOS", @"Than", @"iOS", @"iOS", @"iOS", nil];
        [_dataArray addObject:sectionDataArray];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [_dataArray count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSInteger numberOfActualCells = [[_dataArray objectAtIndex:section] count];
    NSInteger numberOfDummyCells = NUMBER_OF_CELLS_PER_ROW - numberOfActualCells % NUMBER_OF_CELLS_PER_ROW;
    NSInteger numberOfMenuCells = (numberOfActualCells + numberOfDummyCells) / NUMBER_OF_CELLS_PER_ROW;
    
    return numberOfActualCells + numberOfDummyCells + numberOfMenuCells;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    [self clearContentForCell:cell];
    
    if ([self isMenuCellAtIndexPath:indexPath]) {
        cell.backgroundColor = [UIColor blueColor];
        cell.hidden = ![self willMenuCellShowAtIndexPath:indexPath];
    } else {
        NSString *itemContent = [self getItemAtIndexPath:indexPath];
        if (itemContent) {
            cell.hidden = NO;
            UILabel *label;
            
            if (![[cell.contentView subviews] count]) {
                label = [UILabel new];
            
                label.frame = cell.contentView.bounds;
                label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            
                [cell.contentView addSubview:label];
            } else {
                label = [[cell.contentView subviews] objectAtIndex:0];
            }
    
            [label setText:itemContent];
            cell.backgroundColor = [UIColor greenColor];
        } else {
            
            cell.hidden = YES;
            if ([[cell.contentView subviews] count]) {
                UILabel *label = [[cell.contentView subviews] objectAtIndex:0];
                [label setText:@""];
            }
            
            cell.backgroundColor = [UIColor redColor];
        }
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self isMenuCellAtIndexPath:indexPath]) {
        if ([self willMenuCellShowAtIndexPath:indexPath]) {
            return CGSizeMake(self.view.frame.size.width, 80);
        } else {
            return CGSizeZero;
        }
    }
    return CGSizeMake(50, 50);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (![self isMenuCellAtIndexPath:indexPath] && ![self isDummyCellAtIndexPath:indexPath]) {
        [self setMenuCellSection:indexPath.section
                             row:((indexPath.row / (NUMBER_OF_CELLS_PER_ROW + 1)) + 1) * (NUMBER_OF_CELLS_PER_ROW + 1) - 1];
    } else {
        [self setMenuCellSection:-1 row:-1];
    }
    
    [_collectionView reloadData];
}

- (BOOL)isMenuCellAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row != 0 && (indexPath.row + 1) % (NUMBER_OF_CELLS_PER_ROW + 1) == 0;
}

- (BOOL)isDummyCellAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger actualRow = indexPath.row - indexPath.row / NUMBER_OF_CELLS_PER_ROW;
    return actualRow >= [[_dataArray objectAtIndex:indexPath.section] count];
}

- (id)getItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger actualRow = indexPath.row - indexPath.row / NUMBER_OF_CELLS_PER_ROW;
    if (actualRow >= [[_dataArray objectAtIndex:indexPath.section] count]) {
        return nil;
    }
    return [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:actualRow];
}

- (void)clearContentForCell:(UICollectionViewCell *)cell {
    if (cell && [[cell subviews] count]) {
        UILabel *label = [[cell subviews] objectAtIndex:0];
        if ([label isKindOfClass:[UILabel class]]) {
            [label setText:@""];
        }
    }
}

- (void)setMenuCellSection:(NSInteger)section row:(NSInteger)row {
    _sectionOfMenuCell = section;
    _rowOfMenuCell = row;
}

- (BOOL)willMenuCellShowAtIndexPath:(NSIndexPath *)indexPath {
    return _sectionOfMenuCell == indexPath.section && _rowOfMenuCell == indexPath.row;
}

@end
