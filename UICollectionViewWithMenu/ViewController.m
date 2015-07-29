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
@property (nonatomic, assign) NSInteger sectionOfMenuCell;
@property (nonatomic, assign) NSInteger rowOfMenuCell;

@end

@implementation ViewController

- (instancetype)init {
    if (self = [super init]) {
        NSMutableArray *array = [NSMutableArray array];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
        NSDate *capturedStartDate = [dateFormatter dateFromString: @"2012-09-16 23:59:59 JST"];
        
        NSMutableArray *dates = [NSMutableArray new];
        
        for (int i = 0; i < 10; i++) {
            Item *item = [Item new];
            item.date = [self generateRandomDate];
            [dates addObject:item.date];
            item.name = [NSString stringWithFormat:@"item %d", i];
            [array addObject:item];
        }
        
        NSArray *sortedDates = [dates sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj2 compare:obj1];
        }];
        
        NSLog(@"%@", sortedDates);
        NSLog(@"%@", [dates sortedArrayUsingSelector:@selector(compare:)]);
        
        return self;
        
        NSMutableDictionary *result = [NSMutableDictionary new];
        NSArray *distinctDates;
        distinctDates = [array valueForKeyPath:@"@distinctUnionOfObjects.date"];
        for (NSDate *date in distinctDates) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date = %@", date];
            NSArray *items = [array filteredArrayUsingPredicate:predicate];
            [result setObject:items forKey:date];
        }
        
        NSLog(@"%@", result);
    }
    
    return self;
}

- (NSDate *)generateRandomDate {
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:today];
    NSRange days = [calendar rangeOfUnit:NSDayCalendarUnit
                                  inUnit:NSMonthCalendarUnit
                                 forDate:today];
    int r = arc4random() % days.length;
    [dateComponents setDay:r];
    NSDate *startDate = [calendar dateFromComponents:dateComponents];
    
    return startDate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [aButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [aButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    aButton.titleLabel.textColor = [UIColor redColor];
    [aButton setTitle:@"My BUTTON" forState:UIControlStateNormal];
    //[aButton addTarget:self action:@selector(buttonPushed) forControlEvents:UIControlEventsTouchUpInside];
    [self.view addSubview:aButton];
    
    return;
    
    
    
    // create an UICollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //layout.sectionInset = UIEdgeInsetsMake(4, 4, 0, 0);
    //layout.minimumInteritemSpacing = 4.f;
    //layout.minimumLineSpacing = 4.f;
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
                                     @"Android", @"iOS", @"Than", @"iOS", @"hello", @"world", nil];
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
            
            cell.hidden = NO;
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
            return CGSizeMake(self.view.frame.size.width - 4, 247);
        } else {
            return CGSizeZero;
        }
    }
    return CGSizeMake(166, 223);
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

- (void)setMenuCellIndexPath:(NSIndexPath *)indexPath {
    _sectionOfMenuCell = indexPath.section;
    _rowOfMenuCell = indexPath.row;
}

- (BOOL)willMenuCellShowAtIndexPath:(NSIndexPath *)indexPath {
    return _sectionOfMenuCell == indexPath.section && _rowOfMenuCell == indexPath.row;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 4.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4.0;
}

// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // return UIEdgeInsetsMake(0,8,0,8);  // top, left, bottom, right
    return UIEdgeInsetsMake(0, 0, 0, 0);  // top, left, bottom, right
}

@end
