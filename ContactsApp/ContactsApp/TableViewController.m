//
//  TableViewController.m
//  ContactsApp
//
//  Created by David Perkins on 5/9/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "TableViewController.h"
#import "ContactInfo.h"
#import "TableViewCell.h"
#import "ViewController.h"

@interface TableViewController ()
@property (nonatomic,strong) ContactInfo *contacts;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _contacts = [[ContactInfo alloc]init];
    
    
    [[[self navigationController]navigationBar]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0: return (NSInteger)_contacts.recent.count; // 3
        case 1: return (NSInteger)_contacts.friends.count; // 6
        default: return 0;
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0: return @"Recent";
        case 1: return @"Friends";
        default: return @"";
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    header.contentView.backgroundColor = [UIColor lightTextColor];
    header.textLabel.textColor = [UIColor blackColor];
    header.textLabel.font = [UIFont boldSystemFontOfSize:18];
    CGRect headerFrame = header.frame;
    header.textLabel.frame = headerFrame;
    header.textLabel.textAlignment = NSTextAlignmentLeft;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"segue" sender:[tableView cellForRowAtIndexPath:indexPath]];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"segue"]) {
        
        ViewController *secondVC = (ViewController*)segue.destinationViewController;
        
        switch ([sender tag]) {
            case 0:
                
                for (NSDictionary *dict in _contacts.recent) {
                    if ([[dict valueForKey:@"name"]isEqualToString:[[sender nameLabel]text]]) {
                        
                        NSUInteger index = [[_contacts recent]indexOfObject:dict];
                        
                        secondVC.name = _contacts.recent[index][@"name"];
                        secondVC.email = _contacts.recent[index][@"email"];
                        secondVC.phone = _contacts.recent[index][@"mobile"];
                        secondVC.note = _contacts.recent[index][@"notes"];
                        secondVC.avatar = [UIImage imageNamed: _contacts.recent[index][@"avatarBig"]];
                        
                    }
                }
            case 1:
                for (NSDictionary *dict in _contacts.friends) {
                    if ([[dict valueForKey:@"name"]isEqualToString:[[sender nameLabel]text]]) {
                        
                        NSUInteger index = [[_contacts friends]indexOfObject:dict];
                        
                        secondVC.name = _contacts.friends[index][@"name"];
                        secondVC.email = _contacts.friends[index][@"email"];
                        secondVC.phone = _contacts.friends[index][@"mobile"];
                        secondVC.note = _contacts.friends[index][@"notes"];
                        secondVC.avatar = [UIImage imageNamed: _contacts.friends[index][@"avatarBig"]];
                    }
                }
                
            default:
                break;
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.imgView.layer.cornerRadius = cell.imgView.frame.size.width / 2;
    cell.imgView.clipsToBounds = YES;
    
    switch (indexPath.section) {
        case 0:
            cell.nameLabel.text = _contacts.recent[indexPath.row][@"name"];
            cell.imgView.image = [UIImage imageNamed: [NSString stringWithFormat: @"%@", _contacts.recent[indexPath.row][@"avatar"]]];
            cell.tag = 0;
            return cell;
        case 1:
            cell.nameLabel.text = _contacts.friends[indexPath.row][@"name"];
            cell.imgView.image = [UIImage imageNamed: [NSString stringWithFormat: @"%@", _contacts.friends[indexPath.row][@"avatar"]]];
            cell.tag = 1;
            return cell;
        default:
            return cell;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
