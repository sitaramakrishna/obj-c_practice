//
//  ViewController.h
//  Core Data
//
//  Created by David Perkins on 5/10/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *versionTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;


- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@end

