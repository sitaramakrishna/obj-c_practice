//
//  ViewController.m
//  SpringAnimations
//
//  Created by David Perkins on 5/24/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *overlay;
@property (strong, nonatomic) CALayer *mask;
@property (strong, nonatomic) CABasicAnimation *animation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self animateLaunchWithImage:[UIImage imageNamed:@"twitterlogo"] andBGColor:[UIColor colorWithRed:85/255 green:172/255 blue:238/255 alpha:1.0]];
}

-(void)animateLaunchWithImage:(UIImage *)image andBGColor:(UIColor *)bgColor {
    
    [self.view setBackgroundColor:bgColor];
    
    // Create and apply mask
    _mask = [[CALayer alloc]init];
    _mask.contents = (id)image.CGImage;
    _mask.bounds = CGRectMake(0, 0, 100, 100);
    _mask.anchorPoint = CGPointMake(0.5, 0.5);
    _mask.position = CGPointMake(_mainView.frame.size.width / 2.0, _mainView.frame.size.height / 2.0);
    _mainView.layer.mask = _mask;
    
    [self animateDecreaseSize];
    
}

-(void)animateDecreaseSize {
    
    // Initial decrease the size of the mask
    CABasicAnimation *decreaseSize = [[CABasicAnimation alloc]init];
    decreaseSize.keyPath = @"bounds";
    decreaseSize.delegate = self;
    decreaseSize.duration = 0.4;
    decreaseSize.fromValue = [NSValue valueWithCGRect:_mask.bounds];
    decreaseSize.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 80, 80)];
    
    // Ensure that the animation isn't removed on completion
    decreaseSize.fillMode = kCAFillModeForwards;
    decreaseSize.removedOnCompletion = NO;
    
    // Add animation to mask
    [_mask addAnimation:decreaseSize forKey:@"bounds"];
    
}

-(void)animateIncreaseSize {
    
    // Initial decrease the size of the mask
    _animation = [[CABasicAnimation alloc]init];
    _animation.keyPath = @"bounds";
    _animation.duration = 0.75;
    _animation.fromValue = [NSValue valueWithCGRect:_mask.bounds];
    _animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 4000, 4000)];
    
    // Ensure that the animation isn't removed on completion
    _animation.fillMode = kCAFillModeForwards;
    _animation.removedOnCompletion = NO;
    
    // Add animation to mask
    [_mask addAnimation:_animation forKey:@"bounds"];
    
    [UIView animateWithDuration:0.75 animations:^{
        self.overlay.alpha = 0;
    }];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    // Called when animateDecreaseSize: is completed
    [self animateIncreaseSize];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
