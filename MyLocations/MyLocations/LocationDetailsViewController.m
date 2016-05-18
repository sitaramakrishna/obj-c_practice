//
//  LocationDetailsViewController.m
//  MyLocations
//
//  Created by David Perkins on 5/13/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "LocationDetailsViewController.h"
#import "CategoryPickerViewController.h"
#import "HudView.h"
#import "Location.h"

@interface LocationDetailsViewController () <UITextViewDelegate> // Class extension

@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, weak) IBOutlet UILabel *categoryLabel;
@property (nonatomic, weak) IBOutlet UILabel *latitudeLabel;
@property (nonatomic, weak) IBOutlet UILabel *longitudeLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) NSString *descriptionText;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSDate *date;
@end

@implementation LocationDetailsViewController

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super initWithCoder:aDecoder])) {
        
        _descriptionText = @"";
        _categoryName = @"No Category";
        _date = [NSDate date];
    }
    
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.descriptionTextView.text = @"";
    self.categoryLabel.text = _categoryName;
    
    self.latitudeLabel.text = [NSString stringWithFormat:@"%.8f", self.coordinate.latitude];
    self.longitudeLabel.text = [NSString stringWithFormat:@"%.8f", self.coordinate.longitude];
    
    if (self.placemark != nil) {
        self.addressLabel.text = [self stringFromPlacemark: self.placemark];
    } else {
        self.addressLabel.text = @"No Address Found";
    }
    
    self.dateLabel.text = [self formatDate:_date];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard:)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:gestureRecognizer];
}

-(void)hideKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    
    CGPoint point = [gestureRecognizer locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    
    if (indexPath != nil && indexPath.section == 0 && indexPath.row == 0) {
        return;
    }
    
    [self.descriptionTextView resignFirstResponder];
    
}

-(NSString *)stringFromPlacemark:(CLPlacemark *)placemark {
    
    return [NSString stringWithFormat:@"%@ %@\n %@, %@ %@\n %@", placemark.subThoroughfare, placemark.thoroughfare, placemark.locality, placemark.administrativeArea, placemark.postalCode, placemark.country];
}

-(NSString *)formatDate:(NSDate *)theDate {
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc]init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
    }
    
    return [formatter stringFromDate:theDate];
}


- (IBAction)done:(id)sender {

    HudView *hudView = [HudView hudInView:self.navigationController.view animated:YES];
    
    hudView.text = @"Tagged";

    // Saving to Core Data
    Location *location = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
    
    location.locationDescription = _descriptionText;
    location.category = _categoryName;
    location.latitude = @(self.coordinate.latitude);
    location.longitude = @(self.coordinate.longitude);
    location.date = _date;
    location.placemark = self.placemark;
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error: %@", error);
        FATAL_CORE_DATA_ERROR(error);
        return;
    }
    
    [self performSelector:@selector(closeScreen) withObject:nil afterDelay:0.6];
}


- (IBAction)cancel:(id)sender {

    [self closeScreen];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"Pick Category"]) {
        
        CategoryPickerViewController *controller = segue.destinationViewController;
        controller.selectedCategoryName = _categoryName;
        
    }
    
}

-(void)closeScreen {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

// Unwind segue - method is called when cell is tapped in CategoryPickerVC
-(IBAction)categoryPickerDidPickCategory:(UIStoryboardSegue *)segue {
    
    CategoryPickerViewController *viewController = segue.sourceViewController;
    
    _categoryName = viewController.selectedCategoryName;
    
    self.categoryLabel.text = _categoryName;
    
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 88;
    
    } else if (indexPath.section == 2 && indexPath.row == 2) {
        
        CGRect rect = CGRectMake(100, 10, 205, 10000);
        self.addressLabel.frame = rect;
        [self.addressLabel sizeToFit];
        
        rect.size.height = self.addressLabel.frame.size.height;
        self.addressLabel.frame = rect;
        
        return self.addressLabel.frame.size.height + 20;
    
    } else {
        
        return 44;
        
    }
    
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        return indexPath;
    } else {
        return nil;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        [self.descriptionTextView becomeFirstResponder];
    }
    
}

#pragma mark - UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    _descriptionText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    return YES;
    
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    _descriptionText = textView.text;
}

@end





