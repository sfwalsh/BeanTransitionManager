//
//  BTMPhotoCellCollectionViewCell.h
//  BeanTransitionManager
//
//  Created by Stephen Walsh on 23/04/2015.
//  Copyright (c) 2015 Stephen Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTMPhoto.h"

@interface BTMPhotoCellCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *cellImageView;
- (void)setupViewWithPhoto:(BTMPhoto*)photo;

@end
