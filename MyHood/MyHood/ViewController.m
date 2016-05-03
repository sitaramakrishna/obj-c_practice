//
//  ViewController.m
//  MyHood
//
//  Created by David Perkins on 5/1/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ViewController.h"
#import "DataService.h"
#import "Post.h"
#import "PostCell.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) DataService *dataService;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _dataService = [[DataService alloc]init];
    [[_dataService instance]loadPosts];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onPostsLoaded:) name:@"postsLoaded" object:nil];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 87.0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Post *post = _dataService.loadedPosts[indexPath.row];
    NSLog(@"cellForRowAtIndexPath: %@", post);
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    if (cell) {
        [cell configureCell:post];
        return cell;
    } else {
        PostCell *cell;
        [cell configureCell:post];
        return cell;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  1; //_dataService.loadedPosts.count;
    
}

-(void)onPostsLoaded:(id)notif {
    NSLog(@"onPostsLoaded %@",_dataService.loadedPosts);
    [[self tableView]reloadData];
}

@end
