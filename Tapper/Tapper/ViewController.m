//
//  ViewController.m
//  Tapper
//
//  Created by David Perkins on 4/27/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tapsToWin = [NSNumber numberWithInt:0];
    _currentNumberTaps = [NSNumber numberWithInt:0];
    
    _numTapsLabel.text = @"0";
    
    _tapperLogo.hidden = false;
    _textField.hidden = false;
    _numTapsLabel.hidden = true;
    _playBtn.hidden = false;
    _tapBtn.hidden = true;
    
}



- (IBAction)tapBtnPressed:(id)sender {
    
    _currentNumberTaps =  [NSNumber numberWithInt:[_currentNumberTaps intValue] + 1];
    
    NSLog(@"%@", _currentNumberTaps);
    
    NSLog(@"%@", _tapsToWin);
    
    if (_currentNumberTaps < _tapsToWin) {
        
        _numTapsLabel.text = [NSString stringWithFormat:@"%@", _currentNumberTaps];
        
    } else {
        
        // player has won
        
        _numTapsLabel.text = @"You won!";
        
        _tapsToWin = [NSNumber numberWithInt:0];
        _currentNumberTaps = [NSNumber numberWithInt:0];
        
        _tapperLogo.hidden = false;
        _textField.hidden = false;
        _numTapsLabel.hidden = false;
        _playBtn.hidden = false;
        _tapBtn.hidden = true;
        
    }
    
}

- (IBAction)playBtnPressed:(id)sender {
    
    _numTapsLabel.text = @"0";
    
    if (_textField.text.intValue > 0) {
    
        _currentNumberTaps = [NSNumber numberWithInt:0];
        
        _tapsToWin = [NSNumber numberWithInt:_textField.text.integerValue];
        
        _tapperLogo.hidden = true;
        _textField.hidden = true;
        _numTapsLabel.hidden = false;
        _playBtn.hidden = true;
        _tapBtn.hidden = false;
        
    }
    
}

@end
