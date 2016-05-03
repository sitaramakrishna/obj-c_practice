//
//  PostCell.m
//  MyHood
//
//  Created by David Perkins on 5/2/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "PostCell.h"
#import "DataService.h"

@interface PostCell ()

@property (weak, nonatomic) IBOutlet UIImageView *postImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (nonatomic) DataService *dataService;

@end

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _postImg.layer.cornerRadius = _postImg.frame.size.width / 2;
    _postImg.clipsToBounds = YES;
}

-(void)configureCell:(Post *)post {
    NSLog(@"configureCell %@", post.title);
    _titleLabel.text = post.title;
    _descLabel.text = post.postDesc;
    _postImg.image = [[_dataService instance]imageForPath:post.imagePath];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
