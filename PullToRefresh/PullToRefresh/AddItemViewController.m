//
//  AddItemViewController.m
//  TableViews
//
//  Created by David Perkins on 5/7/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "AddItemViewController.h"
#import "Groceries.h"

@interface AddItemViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) Groceries *groceries;
@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _groceries = [[Groceries alloc]init];
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        
        [[_groceries groceryList]addObject:_textView.text];
        NSLog(@"1%@", _groceries.groceryList);
//        [textView resignFirstResponder];
//        [[self navigationController]popViewControllerAnimated:YES];
        return NO;
    }
    
    return YES;
}

@end
