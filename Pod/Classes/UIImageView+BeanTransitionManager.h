//
//  UIImageView+BeanTransitionManager.h
//  Pods
//
//  Created by Stephen Walsh on 23/04/2015.
//
//

#import <UIKit/UIKit.h>

@interface UIImageView (BeanTransitionManagerConvienence)

- (void)expandToFullscreenWithDuration:(NSTimeInterval)duration;
- (void)destroyAllConstraintsAndAlignToView:(UIView*)view;

@end