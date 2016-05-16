//
//  ViewController.m
//  CoreMotion
//
//  Created by David Perkins on 5/15/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAccelerometerDelegate>

@end

@implementation ViewController
{
    NSTimer *timer;
}

#define degrees(x) (180 * x / M_PI)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    currentMaxAccelX = 0;
    currentMaxAccelY = 0;
    currentMaxAccelZ = 0;
    
    currentMaxRotX = 0;
    currentMaxRotY = 0;
    currentMaxRotZ = 0;
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.deviceMotionUpdateInterval = 1/60;
    [self.motionManager startDeviceMotionUpdates];
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
        
        [self outputAccelerationData:accelerometerData.acceleration];
    
        if(error){
            NSLog(@"%@", error);
        }
    }];
    
    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMGyroData *gyroData, NSError *error) {
    
        [self outputRotationData:gyroData.rotationRate];
    
    }];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1/60 target:self selector:@selector(read) userInfo:nil repeats:YES];
    
}

-(void)outputAccelerationData:(CMAcceleration)acceleration {
    
    self.accX.text = [NSString stringWithFormat:@" %.2fg",acceleration.x];
    if(fabs(acceleration.x) > fabs(currentMaxAccelX)) {
        currentMaxAccelX = acceleration.x;
    }
    
    self.accY.text = [NSString stringWithFormat:@" %.2fg",acceleration.y];
    if(fabs(acceleration.y) > fabs(currentMaxAccelY)) {
        currentMaxAccelY = acceleration.y;
    }
    
    self.accZ.text = [NSString stringWithFormat:@" %.2fg",acceleration.z];
    if(fabs(acceleration.z) > fabs(currentMaxAccelZ)) {
        currentMaxAccelZ = acceleration.z;
    }
    
    self.maxAccX.text = [NSString stringWithFormat:@" %.2f",currentMaxAccelX];
    self.maxAccY.text = [NSString stringWithFormat:@" %.2f",currentMaxAccelY];
    self.maxAccZ.text = [NSString stringWithFormat:@" %.2f",currentMaxAccelZ];
    
    
}

-(void)outputRotationData:(CMRotationRate)rotation {
    
    self.rotX.text = [NSString stringWithFormat:@" %.2fr/s",rotation.x];
    if(fabs(rotation.x) > fabs(currentMaxRotX))
    {
        currentMaxRotX = rotation.x;
    }
    self.rotY.text = [NSString stringWithFormat:@" %.2fr/s",rotation.y];
    if(fabs(rotation.y) > fabs(currentMaxRotY))
    {
        currentMaxRotY = rotation.y;
    }
    self.rotZ.text = [NSString stringWithFormat:@" %.2fr/s",rotation.z];
    if(fabs(rotation.z) > fabs(currentMaxRotZ))
    {
        currentMaxRotZ = rotation.z;
    }
    
    self.maxRotX.text = [NSString stringWithFormat:@" %.2f",currentMaxRotX];
    self.maxRotY.text = [NSString stringWithFormat:@" %.2f",currentMaxRotY];
    self.maxRotZ.text = [NSString stringWithFormat:@" %.2f",currentMaxRotZ];
}

-(void)read {
    
    CMAttitude *attitude;
    CMDeviceMotion *motion = _motionManager.deviceMotion;
    attitude = motion.attitude;
    
    self.angleX.text = [NSString stringWithFormat:@"%.2f°", degrees(attitude.yaw)]; // In addition to pitch, there's also yaw and roll
    self.angleY.text = [NSString stringWithFormat:@"%.2f°", degrees(attitude.pitch)]; // In addition to pitch, there's also yaw and roll
    self.angleZ.text = [NSString stringWithFormat:@"%.2f°", degrees(attitude.roll)]; // In addition to pitch, there's also yaw and roll

    
}

- (IBAction)resetMaxValues:(id)sender {
    
    currentMaxAccelX = 0;
    currentMaxAccelY = 0;
    currentMaxAccelZ = 0;
    
    currentMaxRotX = 0;
    currentMaxRotY = 0;
    currentMaxRotZ = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
