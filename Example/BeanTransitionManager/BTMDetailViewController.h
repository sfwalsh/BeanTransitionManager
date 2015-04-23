//
//  BTMDetailViewController.h
//  BeanTransitionManager
//
//  Created by Stephen Walsh on 23/04/2015.
//  Copyright (c) 2015 Stephen Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeanTransitionManager.h"
#import "BTMPhoto.h"

@interface BTMDetailViewController : UIViewController <BeanTransitionManagerDelegate>

@property (nonatomic, readonly) UIImageView *delegateContentImageView;
@property (nonatomic, weak) BTMPhoto *photo;

@end
