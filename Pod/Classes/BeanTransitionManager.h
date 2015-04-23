//
//  BeanTransitionManager.h
//  Pods
//
//  Created by Stephen Walsh on 23/04/2015.
//
//

#import <Foundation/Foundation.h>
#import "UIImageView+BeanTransitionManager.h"

@protocol BeanTransitionManagerDelegate <NSObject>

@property (nonatomic, readonly) UIImageView *delegateContentImageView;

@end


@interface BeanTransitionManager : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) id <BeanTransitionManagerDelegate> delegate;

- (instancetype)initWithExpandingImageView:(UIImageView*)expandingImageView andTransitionDuration:(NSTimeInterval)duration;
- (instancetype)initWithExpandingImageView:(UIImageView*)expandingImageView;

@end
