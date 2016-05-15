//
//  ViewController.m
//  L7Weenie
//
//  Created by David Perkins on 5/14/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController () <FBSDKLoginButtonDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.center = self.view.center;
    loginButton.readPermissions = @[@"read_mailbox"];
    [self.view addSubview:loginButton];
    
}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {

    if ((error) != nil) {

        [self performSegueWithIdentifier:@"LoginSuccessful" sender:self];

    } else if (result.isCancelled) {

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"There was an error. Please try again." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:ok];

    } else {

        if ([result.grantedPermissions containsObject:@"read_mailbox"]) {

            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning:" message:@"This app is utterly useless without granting the \"read_mailbox\" permission." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:ok];
    
        }
        
    }
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
