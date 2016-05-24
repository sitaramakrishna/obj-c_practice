//
//  DetailViewController.m
//  UISearchController
//
//  Created by David Perkins on 5/23/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "DetailViewController.h"
#import "MasterViewController.h"
#import "Candy.h"

@interface DetailViewController ()

@property (nonatomic, weak) IBOutlet UILabel *detailDescriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *candyImageView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureView];
    
}

-(void)configureView {
    
    if ((_detailCandy != nil) && (_detailDescriptionLabel != nil) && (_candyImageView != nil)) {
    
        _detailDescriptionLabel.text = _detailCandy.name;
        _candyImageView.image = [UIImage imageNamed:_detailCandy.name];
        self.title = _detailCandy.category;
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
