//
//  ViewController.m
//  IconMemory
//
//  Created by Anthony Muto on 8/25/15.
//  Copyright (c) 2015 Anthony Muto. All rights reserved.
//

#import "ViewController.h"
#import "MemoryCell.h"

#define NUMOF_MEMORY_ITEMS 24
#define COLCELL_IDENTIFER @"MEMORY_CELL"
#define COLCELL_SIZE CGSizeMake(50, 50)

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *collectionInfoArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *flippedIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor], NSForegroundColorAttributeName,
                                    [UIColor whiteColor], NSBackgroundColorAttributeName,nil];
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    
    self.collectionInfoArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < NUMOF_MEMORY_ITEMS; i++) {
        [_collectionInfoArray addObject:@(i)];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _collectionInfoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = COLCELL_IDENTIFER;
    MemoryCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    [cell.imageView setImage:[UIImage imageNamed:@"cardBg"]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return COLCELL_SIZE;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(100, 60, 0, 60);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10.0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MemoryCell* cell = (MemoryCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [cell.superview bringSubviewToFront:collectionView];
    
    [UIView transitionWithView:cell
                      duration:nil
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [UICollectionViewCell commitAnimations];
                        cell.transform = CGAffineTransformMakeRotation(0.0);
                        
                        if ([cell.imageView.image isEqual:[UIImage imageNamed:@"cardBg2"]])
                            [cell.imageView setImage:[UIImage imageNamed:@"cardBg"]];
                        else
                            [cell.imageView setImage:[UIImage imageNamed:@"cardBg2"]];
                    }
                    completion:^(BOOL finished) {}];
}

@end
