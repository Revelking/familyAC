//
//  ShiTableViewCell.m
//  AdventureClub
//
//  Created by wang on 16/5/10.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "ShiTableViewCell.h"

@implementation ShiTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [_image1 setUserInteractionEnabled:YES];
    //     [_imageIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCategory)]];
    UITapGestureRecognizer *photoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)];
    [self.image1 addGestureRecognizer:photoTap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)photoTap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        if (_delegate && _indexPath && [_delegate respondsToSelector:@selector(photoTapAtIndexPath:)]) {
            [_delegate photoTapAtIndexPath:_indexPath];
        }
    }
}
@end
