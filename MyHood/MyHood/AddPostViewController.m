//
//  AddPostViewController.m
//  MyHood
//
//  Created by David Perkins on 5/1/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "AddPostViewController.h"
#import "DataService.h"
#import "Post.h"

@interface AddPostViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *postImg;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *descField;
@property (nonatomic) UIImagePickerController *imagePicker;
@property (nonatomic) DataService *dataService;
- (IBAction)addPicBtnPressed:(UIButton *)sender;
- (IBAction)makePostBtnPressed:(UIButton *)sender;
- (IBAction)cancelBtnPressed:(UIButton *)sender;

@end

@implementation AddPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataService = [[DataService alloc]init];
    _imagePicker = [[UIImagePickerController alloc]init];
    _imagePicker.delegate = self;
    _postImg.layer.cornerRadius = _postImg.frame.size.width / 2;
    _postImg.clipsToBounds = YES;
    UIImagePickerController *imagePicker;
    imagePicker.delegate = self;
    
}

-(void)addPicBtnPressed:(UIButton *)sender {
    
    [sender setTitle:@"" forState:UIControlStateNormal];
    [self presentViewController:_imagePicker animated:YES completion:nil];
    
}

- (IBAction)makePostBtnPressed:(UIButton *)sender {
    
    NSString *title = _titleField.text;
    NSString *desc = _descField.text;
    UIImage *img = _postImg.image;
    
    if (title && desc && img) {
        
        NSString *imgPath = [[_dataService instance]saveImageAndCreatePath:img];
        Post *post = [[Post alloc]initWithImagePath:imgPath title:title description:desc];
        
        [_dataService addPost:post];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}

- (IBAction)cancelBtnPressed:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [[self imagePicker]dismissViewControllerAnimated:YES completion:nil];
    _postImg.image = info[UIImagePickerControllerOriginalImage];
    
    
}



@end
