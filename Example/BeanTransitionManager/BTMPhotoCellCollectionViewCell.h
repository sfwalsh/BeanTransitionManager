//
//  BTMPhotoCellCollectionViewCell.h
//  BeanTransitionManager
//
//  Created by Stephen Walsh on 23/04/2015.
//  Copyright (c) 2015 Stephen Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTMPhoto.h"
#import "BeanTransitionManagerGenerator.h"

@interface BTMPhotoCellCollectionViewCell : UICollectionViewCell <BeanTransitionManagerCellExpanding>

@property (nonatomic, readonly) UIImageView *cellImageView;
@property (nonatomic, weak) IBOutlet UIImageView *photoImageView;

- (void)setupViewWithPhoto:(BTMPhoto*)photo;

@end
