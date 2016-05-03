//
//  PostCell.h
//  MyHood
//
//  Created by David Perkins on 5/2/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface PostCell : UITableViewCell

-(void)configureCell:(Post *)post;

@end
