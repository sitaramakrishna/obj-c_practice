//
//  ViewController.m
//  SuperCool
//
//  Created by David Perkins on 4/26/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *boomApp;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIButton *makeMeCoolButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)makeMeCoolBtn:(id)sender {
    
    _boomApp.hidden = false;
    _background.hidden = false;
    _makeMeCoolButton.hidden = true;
    
}



@end
