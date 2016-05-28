//
//  ViewController.m
//  ExpandTransitionAnimation
//
//  Created by David Perkins on 5/26/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"
#import "ExpandAnimator.h"
#import "SecondViewController.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic) CGRect openingFrame;
@property (nonatomic, strong) ExpandAnimator *animator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _animator = [[ExpandAnimator alloc]init];
    
    _colorArray = [NSArray arrayWithObjects:@"FFD36C",@"49B2BD",@"DC3565",@"A692CB",@"FFD36C",@"49B2BD", nil];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - UIViewAnimatedTransitioning
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    ExpandAnimator *presentationAnimator = _animator;
    presentationAnimator.openingFrame = _openingFrame;
    presentationAnimator.transitionMode = ExpandTransitionModePresent;
    
    return presentationAnimator;
    
} 

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    ExpandAnimator *presentationAnimator = _animator;
    presentationAnimator.openingFrame = _openingFrame;
    presentationAnimator.transitionMode = ExpandTransitionModeDismiss;
    
    return presentationAnimator;
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width, 150);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [self colorFromHexString:_colorArray[indexPath.row]];
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Set frame of cell
    UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect attributesFrame = attributes.frame;
    CGRect frameToOpenFrom = [collectionView convertRect:attributesFrame toView:collectionView.superview];
    _openingFrame = frameToOpenFrom;
    
    // Present view controller
    SecondViewController *secondVC = [[SecondViewController alloc]init];
    secondVC.transitioningDelegate = self;
    secondVC.modalPresentationStyle = UIModalPresentationCustom;
    secondVC.view.backgroundColor = [self colorFromHexString: _colorArray[indexPath.row]];
    [self presentViewController:secondVC animated:YES completion:nil];
    
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end







