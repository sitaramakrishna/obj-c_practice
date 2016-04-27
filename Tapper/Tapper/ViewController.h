//
//  ViewController.h
//  Tapper
//
//  Created by David Perkins on 4/27/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *tapperLogo;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *numTapsLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *tapBtn;

@property (nonatomic) NSNumber *currentNumberTaps;
@property (nonatomic) NSNumber *tapsToWin;

- (IBAction)tapBtnPressed:(id)sender;
- (IBAction)playBtnPressed:(id)sender;


@end

