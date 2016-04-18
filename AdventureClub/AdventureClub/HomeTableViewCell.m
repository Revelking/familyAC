//
//  HomeTableViewCell.m
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/17.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [_imageIV setUserInteractionEnabled:YES];
    //     [_imageIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCategory)]];
    UITapGestureRecognizer *photoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)];
    [self.imageIV addGestureRecognizer:photoTap];
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
