//
//  ViewController.m
//  TipCalculator
//
//  Created by David Perkins on 5/5/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"
#import "Calculations.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *subtotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (nonatomic,strong) Calculations *calculations;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _calculations = [[Calculations alloc]init];
    
    
}


- (IBAction)sliderChanged:(id)sender {
    
    float subtotal = [[_subtotalLabel.text stringByReplacingOccurrencesOfString:@"$" withString:@""]floatValue];
    
    _tipPercentLabel.text = [NSString stringWithFormat:@"Tip (%d%%)", (int)[_slider value]];
    
    _tipAmountLabel.text = [NSString stringWithFormat:@"$%f", [_calculations findTipFromSubtotal:subtotal andTipPercent:(float)[_slider value]]];
    
    _totalAmountLabel.text = [NSString stringWithFormat:@"$%f", [_calculations findTotalFromSubtotal:subtotal andTipPercent:(float)[_slider value]]];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
