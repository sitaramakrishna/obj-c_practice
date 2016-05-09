//
//  TableViewController.m
//  TableViewNavigation
//
//  Created by David Perkins on 5/8/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
@property (nonatomic, strong) NSDictionary *dict;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dict = @{
             @"A":@[@"Aladdin",@"Alvin and the Chipmunks",@"Antman"],
             @"B":@[@"Bad Boys",@"Bad News Bears",@"Barbershop",@"Batman Returns",@"Bourne Identity"],
             @"C":@[@"Cabin in the Woods",@"Captain America",@"Charlie and the Chocolate Factory"],
             @"D":@[@"Daddy Day Care",@"Dallas Buyer's Club",@"Dark Knight",@"Dawn of the Planet of the Apes",@"Dude, Where's My Car?"],
             @"E":@[@"Eagle Eye",@"Eight Crazy Nights",@"Elf",@"Entourage",@"Ex Machina"],
             @"F":@[@"Fahrenheit 9/11",@"Fantastic Four",@"Fast and Furious",@"Final Destination"],
             @"G":@[@"Gangs of New York",@"Get Hard",@"Glengarry Glenn Ross",@"Godzilla"],
             @"H":@[@"Hairspray",@"Hall Pass",@"The Hangover",@"Hardball",@"Harold and Kumar",@"Hoosiers"],
             @"I":@[@"Ice Age: The Meltdown",@"The Ides of March",@"I Know What You Did Last Summer"],
             @"J":@[@"Jack and Jill",@"Jackass",@"Jarhead"],
             @"M":@[@"Major League"],
             @"N":@[@"National Treasure",@"Need For Speed",@"Neighbors",@"No Country for Old Men",@"Not Another Teen Movie"],
             @"O":@[@"Ocean's Eleven",@"Old School",@"Open Range"],
             @"P":@[@"Pacific Rim",@"Paranormal Activity",@"Poltergeist",@"Pompeii"]
             };
    
    [[_dict allKeys]sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSString *arrayKey = [[[_dict allKeys]sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] objectAtIndex:indexPath.section];
    
    NSArray *a = [_dict objectForKey:arrayKey];
    
    cell.textLabel.text = [a objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return [[_dict allKeys]sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [[_dict allKeys]sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)][section];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [[[_dict allKeys]sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSString *arrayKey = [[[_dict allKeys]sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] objectAtIndex:section];
    NSArray *a = [_dict objectForKey:arrayKey];
    
    return a.count;
}


@end
