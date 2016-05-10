//
//  ViewController.m
//  ContactsApp
//
//  Created by David Perkins on 5/9/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"
#import "ContactInfo.h"

@interface ViewController ()
@property (nonatomic,strong) ContactInfo *contact;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextView *notesView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = self.name;
    self.nameLabel.text = self.name;
    self.emailLabel.text = self.email;
    self.phoneLabel.text = self.phone;
    self.notesView.text = self.note;
    self.imgView.image = self.avatar;
    self.imgView.layer.cornerRadius = self.imgView.frame.size.width / 2;
    self.imgView.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
