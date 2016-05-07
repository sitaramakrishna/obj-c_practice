//
//  ViewController.m
//  CameraRoll
//
//  Created by David Perkins on 5/6/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)cameraButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) NSMutableAttributedString *attributedString;
//@property (nonatomic, strong) NSTextAttachment *textAttachment;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _attributedString = [[NSMutableAttributedString alloc]init];
//    _textAttachment = [[NSTextAttachment alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cameraButton:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc]init];
    textAttachment.image = image;
    
    NSAttributedString *attString = [[NSAttributedString alloc]init];
    attString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [[_textView textStorage]insertAttributedString:attString atIndex:_textView.selectedRange.location];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
