//
//  ViewController.m
//  FullOfCrap
//
//  Created by David Perkins on 5/14/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "LoginViewController.h"
#import <TwitterKit/TwitterKit.h>


@interface LoginViewController ()

@property (nonatomic,strong) TWTRSessionStore *store;
@property (nonatomic,strong) TWTRSession *lastSession;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _store = [[Twitter sharedInstance] sessionStore];
    _lastSession = _store.session;
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    if (_lastSession) {
        
        [self performSegueWithIdentifier:@"LoginSuccessful" sender:self];
        
    } else {
        
        TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
            if (session) {
                
                [self performSegueWithIdentifier:@"LoginSuccessful" sender:self];
                
            } else {
                NSLog(@"Login error: %@", [error localizedDescription]);
            }
        }];
        
        logInButton.center = self.view.center;
        [self.view addSubview:logInButton];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
