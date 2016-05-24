//
//  TableViewController.m
//  ImageCarousel
//
//  Created by David Perkins on 5/24/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "TableViewController.h"
#import "CollectionViewCell.h"

@interface TableViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *moviesArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _moviesArray = [NSMutableArray arrayWithObjects:@"Iron Man 3", @"Minions", @"Slow Learners", @"Jurassic World", @"Trainwreck", @"Insidious: Chapter 3", @"Inside Out", @"Steve Jobs", @"Black Mass", @"The Angry Birds Movie", nil];
}

#pragma mark - Collection view data source

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed: [NSString stringWithFormat:@"Untitled-%ld", (long)indexPath.row]];
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 4;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.view.frame.size.width, 140);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    *targetContentOffset = scrollView.contentOffset; // set acceleration to 0.0
    float pageWidth = (float)self.collectionView.bounds.size.width;
    int minSpace = 10;
    
    int cellToSwipe = (scrollView.contentOffset.x)/(pageWidth + minSpace) + 0.5; // cell width + min spacing for lines
    if (cellToSwipe < 0) {
        cellToSwipe = 0;
    } else if (cellToSwipe >= self.moviesArray.count) {
        cellToSwipe = self.moviesArray.count - 1;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:cellToSwipe inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _moviesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = _moviesArray[indexPath.row];
    
    return cell;
}




@end
