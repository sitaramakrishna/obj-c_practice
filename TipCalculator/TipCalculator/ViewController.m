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
@property (nonatomic) float subtotal;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _calculations = [[Calculations alloc]init];
    
    _subtotal = [[_subtotalLabel.text stringByReplacingOccurrencesOfString:@"$" withString:@""]floatValue];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    _subtotalLabel.inputAccessoryView = numberToolbar;
    
    [_slider addTarget:self action:@selector(roundValue) forControlEvents:UIControlEventValueChanged];

}


- (IBAction)sliderChanged:(id)sender {
    
    _tipPercentLabel.text = [NSString stringWithFormat:@"Tip (%d%%)", (int)[_slider value]];
    
    _tipAmountLabel.text = [NSString stringWithFormat:@"$%.2f", [_calculations findTipFromSubtotal:_subtotal andTipPercent:floorf([_slider value])]];
    
    _totalAmountLabel.text = [NSString stringWithFormat:@"$%.2f", [_calculations findTotalFromSubtotal:_subtotal andTipPercent:floorf([_slider value])]];

}

-(void)roundValue {
    _slider.value = roundf(_slider.value);
}

-(void)doneWithNumberPad{
    
    NSString *numberFromTheKeyboard = _subtotalLabel.text;
    
    _subtotal = [[numberFromTheKeyboard stringByReplacingOccurrencesOfString:@"$" withString:@""]floatValue];
    
    _subtotalLabel.text = [NSString stringWithFormat:@"$%.2f", _subtotal];
    
    _tipAmountLabel.text = [NSString stringWithFormat:@"$%.2f", [_calculations findTipFromSubtotal:_subtotal andTipPercent:(float)[_slider value]]];
    
    _totalAmountLabel.text = [NSString stringWithFormat:@"$%.2f", [_calculations findTotalFromSubtotal:_subtotal andTipPercent:(float)[_slider value]]];
    
    [_subtotalLabel resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
