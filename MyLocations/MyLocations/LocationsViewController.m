//
//  LocationsViewController.m
//  MyLocations
//
//  Created by David Perkins on 5/17/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "LocationsViewController.h"
#import <CoreData/CoreData.h>
#import "Location.h"
#import "LocationCell.h"
#import "LocationDetailsViewController.h"
#import "UIImage+Resize.h"
#import "NSMutableString+AddText.h"

@interface LocationsViewController () <NSFetchedResultsControllerDelegate>

@end

@implementation LocationsViewController
{
    NSFetchedResultsController *_fetchedResultsController;
}

-(NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController == nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        NSSortDescriptor *sortDescriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"category" ascending:YES];
        NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
        
        [fetchRequest setSortDescriptors:@[sortDescriptor1, sortDescriptor2]];
        
        [fetchRequest setFetchBatchSize:20];
        
        // The fetched results controller will gropu the search results based on value of the category attribute
        _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"category" cacheName:@"Locations"];
        
        _fetchedResultsController.delegate = self;
    }
    return _fetchedResultsController;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [NSFetchedResultsController deleteCacheWithName:@"Locations"];
    
    self.tableView.backgroundColor = [UIColor blackColor];
    
    self.tableView.separatorColor = [UIColor colorWithWhite:1.0f alpha:0.2f];
    
    [self performFetch];
    
    
}

-(void)performFetch {
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error]) {
        FATAL_CORE_DATA_ERROR(error);
        return;
    }
}

-(void)dealloc {
    _fetchedResultsController.delegate = nil;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString: @"EditLocation"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        LocationDetailsViewController *controller = (LocationDetailsViewController *)navigationController.topViewController;
        
        controller.managedObjectContext = self.managedObjectContext;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        Location *location = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        controller.locationToEdit = location;
    }
    
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    
    return [sectionInfo numberOfObjects];

}

// Deleting objects
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Location *location = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        [self.managedObjectContext deleteObject:location];
        
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            FATAL_CORE_DATA_ERROR(error);
            return;
        }
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Location"];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    LocationCell *locationCell = (LocationCell *)cell;

    Location *location = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if ([location.locationDescription length] > 0) {
        
        locationCell.descriptionLabel.text = location.locationDescription;
        
    } else {
        
        locationCell.descriptionLabel.text = @"(No Description)";
        
    }
    
    if (location.placemark != nil) {
        
        NSMutableString *string = [NSMutableString stringWithCapacity:100];
        
        [string addText:location.placemark.subThoroughfare withSeparator:@""];
        
        [string addText:location.placemark.thoroughfare withSeparator:@" "];
        
        [string addText:location.placemark.locality withSeparator:@", "];
                                      
        locationCell.addressLabel.text = string;
    
    } else {
        locationCell.addressLabel.text = [NSString stringWithFormat: @"Lat: %.8f, Long: %.8f", [location.latitude doubleValue], [location.longitude doubleValue]];
    }
    
    UIImage *image = nil;
    
    if ([location hasPhoto]) {
        image = [location photoImage];
        if (image != nil) {
            image = [image resizedImageWithBounds:CGSizeMake(52, 52)];
        }
    }
    
    if (image == nil) {
        image = [UIImage imageNamed:@"No Photo"];
    }
    locationCell.photoImageView.image = image;
    locationCell.backgroundColor = [UIColor blackColor];
    locationCell.descriptionLabel.textColor = [UIColor whiteColor];
    locationCell.descriptionLabel.highlightedTextColor = locationCell.descriptionLabel.textColor;
    locationCell.addressLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.4f];
    locationCell.addressLabel.highlightedTextColor = locationCell.addressLabel.textColor;
    
    UIView *selectionView = [[UIView alloc]initWithFrame:CGRectZero];
    selectionView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.2f];
    locationCell.selectedBackgroundView = selectionView;
    
    locationCell.photoImageView.layer.cornerRadius = locationCell.photoImageView.bounds.size.width / 2.0f;
    locationCell.photoImageView.clipsToBounds = YES;
    locationCell.separatorInset = UIEdgeInsetsMake(0, 82, 0, 0);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [[self.fetchedResultsController sections] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    // The <NSFetchedResultsSectionInfo> protocol contains methods for obtaining the name of section and list of object in that section
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    
    return [[sectionInfo name] uppercaseString];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(15.0f, tableView.sectionHeaderHeight - 14.0f, 300.0f, 14.0f)];
    
    label.font = [UIFont boldSystemFontOfSize:11.0f];
    label.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    label.textColor = [UIColor colorWithWhite:1.0f alpha:0.4f];
    label.backgroundColor = [UIColor clearColor];
    UIView *separator = [[UIView alloc] initWithFrame: CGRectMake(15.0f, tableView.sectionHeaderHeight - 0.5f, tableView.bounds.size.width - 15.0f, 0.5f)];
    separator.backgroundColor = tableView.separatorColor;
    
    UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, tableView.bounds.size.width, tableView.sectionHeaderHeight)];
    
    view.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.85f];
                            
    [view addSubview:label];
    [view addSubview:separator];
    
    return view;
    
}

#pragma mark - NSFetchedResultsControllerDelegate
// This is the standard way of implementing these delegate methods. For many apps, this exact code will suffice and you can simply copy it over.

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    NSLog(@"*** controllerWillChangeContent");
    [self.tableView beginUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            NSLog(@"*** NSFetchedResultsChangeInsert (object)");
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
         
        case NSFetchedResultsChangeDelete:
             NSLog(@"*** NSFetchedResultsChangeDelete (object)");
             [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
             break;
            
        case NSFetchedResultsChangeUpdate:
            
            NSLog(@"*** NSFetchedResultsChangeUpdate (object)");
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
             NSLog(@"*** NSFetchedResultsChangeMove (object)");
             [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
             break;
        default:
            break;
    
    }
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            NSLog(@"*** NSFetchedResultsChangeInsert (section)");
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            NSLog(@"*** NSFetchedResultsChangeDelete (section)");
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    NSLog(@"*** controllerDidChangeContent");
    [self.tableView endUpdates];
}


@end
