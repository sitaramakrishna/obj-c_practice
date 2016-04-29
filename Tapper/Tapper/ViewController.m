//
//  ViewController.m
//  Tapper
//
//  Created by David Perkins on 4/27/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *tapperLogo;
@property (weak, nonatomic) IBOutlet UIButton *tapButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *numberOfTapsLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
- (IBAction)playButtonPressed:(UIButton *)sender;
- (IBAction)tapButtonPressed:(UIButton *)sender;
@property (nonatomic) NSNumber *currentTaps;
@property (nonatomic) NSNumber *tapsToWin;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _currentTaps = 0;
    _tapsToWin = 0;
    _tapperLogo.hidden = false;
    _tapButton.hidden = true;
    _textField.hidden = false;
    _numberOfTapsLabel.hidden = true;
    _playButton.hidden = false;
    
}



- (IBAction)playButtonPressed:(id)sender {
    
    if (_textField.text.intValue > 0) {
        
        _currentTaps = 0;
        _tapsToWin = [NSNumber numberWithInt:_textField.text.intValue];
        _tapperLogo.hidden = true;
        _tapButton.hidden = false;
        _textField.hidden = true;
        _numberOfTapsLabel.hidden = false;
        _playButton.hidden = true;
        
        _numberOfTapsLabel.text = @"0 taps";
        
    }
    
}


- (IBAction)tapButtonPressed:(UIButton *)sender {
    
    _currentTaps = [NSNumber numberWithInt:_currentTaps.intValue + 1];
    
    if (_currentTaps < _tapsToWin) {
        
        _numberOfTapsLabel.text = [NSString stringWithFormat:@"%@ taps", _currentTaps];
        
        
    } else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"You won!" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Woohoo!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            _currentTaps = 0;
            _tapsToWin = 0;
            _tapperLogo.hidden = false;
            _tapButton.hidden = true;
            _textField.hidden = false;
            _numberOfTapsLabel.hidden = true;
            _playButton.hidden = false;
            
        }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:true completion:nil];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_textField resignFirstResponder];
    
}


@end





