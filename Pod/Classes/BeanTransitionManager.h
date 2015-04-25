//
//  BeanTransitionManager.h
//  Pods
//
//  Created by Stephen Walsh on 23/04/2015.
//
//

#import <Foundation/Foundation.h>
#import "UIImageView+BeanTransitionManager.h"

@protocol BeanTransitionManagerCellExpanding <NSObject>

@property (nonatomic, readonly) UIImageView *cellImageView;

@end

@protocol BeanTransitionManagerDelegate <NSObject>

@property (nonatomic, readonly) UIImageView *delegateContentImageView;

@end


@interface BeanTransitionManager : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) id <BeanTransitionManagerDelegate> delegate;

- (instancetype)initWithExpandingImageView:(UIImageView*)expandingImageView andTransitionDuration:(NSTimeInterval)duration;
- (instancetype)initWithExpandingImageView:(UIImageView*)expandingImageView;
- (instancetype)initWithTransitionDuration:(NSTimeInterval)duration;

- (void)updateExpandingImageView:(UIImageView*)expandingImageView;
- (void)updateExpandingImageViewWithCell:(id<BeanTransitionManagerCellExpanding>)cell
                             atIndexPath:(NSIndexPath*)indexPath
                        inCollectionView:(UICollectionView*)collectionView
                                  onView:(UIView*)view
                             andDuration:(NSTimeInterval)duration;

@end
