//
//  ViewController.m
//  DateAndTime
//
//  Created by David Perkins on 5/6/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeDateLabel2;
@property (weak, nonatomic) IBOutlet UILabel *timeZoneLabel;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) NSDateFormatter *formatter2;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSDate *date;
@property (weak, nonatomic) IBOutlet UIImageView *caliImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _date = [NSDate date];
    NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];
    
    _timeZoneLabel.text = [NSString stringWithFormat:@"%@ (%@)", destinationTimeZone.name, destinationTimeZone.abbreviation];
    
    _formatter = [[NSDateFormatter alloc] init];
    _formatter.timeZone = destinationTimeZone;
    [_formatter setDateStyle:NSDateFormatterLongStyle];
    [_formatter setDateFormat:@"E, MMM d, yyyy hh:mm:ss a"];
    _timeDateLabel.text = [_formatter stringFromDate:_date];
    
    _formatter2 = [[NSDateFormatter alloc] init];
    _formatter2.timeZone = destinationTimeZone;
    [_formatter2 setDateStyle:NSDateFormatterLongStyle];
    [_formatter2 setDateFormat:@"MM/dd/yyyy H:mm:ss:SS a"];
    _timeDateLabel2.text = [_formatter2 stringFromDate:_date];
    
    _timer = [[NSTimer alloc]init];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(refreshTime) userInfo:nil repeats:YES];
    
    _caliImageView.transform = CGAffineTransformRotate(_caliImageView.transform, -0.349066);
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
         
        _caliImageView.transform = CGAffineTransformConcat(CGAffineTransformRotate(_caliImageView.transform, 0.698132), CGAffineTransformScale(_caliImageView.transform, 1.4, 1.4));
        
    } completion:nil];
    
}

-(void)refreshTime {
    
    _date = [NSDate date];
    _timeDateLabel.text = [_formatter stringFromDate:_date];
    _timeDateLabel2.text = [_formatter2 stringFromDate:_date];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
