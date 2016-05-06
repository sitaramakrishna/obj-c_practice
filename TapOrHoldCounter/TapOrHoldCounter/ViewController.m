//
//  ViewController.m
//  TapOrHoldCounter
//
//  Created by David Perkins on 5/5/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *tapHoldBtn;
@property (nonatomic) BOOL down;
@property (nonatomic) int count;
@property (nonatomic, strong) NSTimer *timer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.count = 0;
    _countLabel.text = @"0";
    
    [self.tapHoldBtn addTarget:self action:@selector(buttonDown) forControlEvents:UIControlEventTouchDown];
    [self.tapHoldBtn addTarget:self action:@selector(buttonUp) forControlEvents:UIControlEventTouchUpInside];
    
    _timer = [[NSTimer alloc]init];
    
}

-(void)buttonDown {
    
    NSLog(@"down");
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(increment:) userInfo:nil repeats:YES];

}

-(void)buttonUp {
    
    NSLog(@"up");
    
    if (_timer != nil)
        [_timer invalidate];
    _timer = nil;
    
}

- (IBAction)increment:(id)sender {
    
    self.count += 1;
    _countLabel.text = [NSString stringWithFormat:@"%d", self.count];
    
}

- (IBAction)reset:(id)sender {
    
    self.count = 0;
    _countLabel.text = @"0";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
