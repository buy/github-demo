//
//  RepoCellTableViewCell.h
//  GithubDemo
//
//  Created by Chang Liu on 10/29/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepoCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *repoName;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@property (weak, nonatomic) IBOutlet UILabel *starsLabel;
@property (weak, nonatomic) IBOutlet UILabel *forksLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ownerImage;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;


@end
