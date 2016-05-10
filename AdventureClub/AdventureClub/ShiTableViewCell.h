//
//  ShiTableViewCell.h
//  AdventureClub
//
//  Created by wang on 16/5/10.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ActivityTableViewCellDelegate <NSObject>
@required
- (void)photoTapAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface ShiTableViewCell : UITableViewCell
@property (weak, nonatomic) id<ActivityTableViewCellDelegate>delegate;
@property (strong,nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UIImageView *image1;

@property (weak, nonatomic) IBOutlet UILabel *telet;

@end
