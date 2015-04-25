//
//  BTMPhotoCellCollectionViewCell.m
//  BeanTransitionManager
//
//  Created by Stephen Walsh on 23/04/2015.
//  Copyright (c) 2015 Stephen Walsh. All rights reserved.
//

#import "BTMPhotoCellCollectionViewCell.h"

@interface BTMPhotoCellCollectionViewCell()

@property (nonatomic, weak) IBOutlet UILabel *cellLabel;
@property (nonatomic, strong) BTMPhoto *photo;

@end

@implementation BTMPhotoCellCollectionViewCell


#pragma mark - setup
- (void)prepareForReuse
{
    [super prepareForReuse];
}

- (void)setupViewWithPhoto:(BTMPhoto *)photo
{
    self.photoImageView.image = photo.photoImage;
    self.cellLabel.text = photo.photoTitle;
}


#pragma mark - lazy loaders
- (UIImageView *)cellImageView
{
    return self.photoImageView;
}

@end
