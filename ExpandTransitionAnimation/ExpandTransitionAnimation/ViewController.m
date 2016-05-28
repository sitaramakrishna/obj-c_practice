//
//  ViewController.m
//  ExpandTransitionAnimation
//
//  Created by David Perkins on 5/26/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic) CGRect openingFrame;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _colorArray = [NSArray arrayWithObjects:@"FFD36C",@"4982BD",@"DC3565",@"A692CB",@"FFD36C",@"49B2BD", nil];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    
    
}

@end







