//
//  ViewController.h
//  CoreMotion
//
//  Created by David Perkins on 5/15/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

double currentMaxAccelX;
double currentMaxAccelY;
double currentMaxAccelZ;
double currentMaxRotX;
double currentMaxRotY;
double currentMaxRotZ;

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *accX;
@property (strong, nonatomic) IBOutlet UILabel *accY;
@property (strong, nonatomic) IBOutlet UILabel *accZ;

@property (strong, nonatomic) IBOutlet UILabel *maxAccX;
@property (strong, nonatomic) IBOutlet UILabel *maxAccY;
@property (strong, nonatomic) IBOutlet UILabel *maxAccZ;

@property (strong, nonatomic) IBOutlet UILabel *rotX;
@property (strong, nonatomic) IBOutlet UILabel *rotY;
@property (strong, nonatomic) IBOutlet UILabel *rotZ;

@property (strong, nonatomic) IBOutlet UILabel *maxRotX;
@property (strong, nonatomic) IBOutlet UILabel *maxRotY;
@property (strong, nonatomic) IBOutlet UILabel *maxRotZ;

@property (strong, nonatomic) IBOutlet UILabel *angleX;
@property (strong, nonatomic) IBOutlet UILabel *angleY;
@property (strong, nonatomic) IBOutlet UILabel *angleZ;


- (IBAction)resetMaxValues:(id)sender;

@property (strong, nonatomic) CMMotionManager *motionManager;

@end

