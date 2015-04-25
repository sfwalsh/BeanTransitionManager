//
//  BeanTransitionManagerGenerator.m
//  Pods
//
//  Created by Stephen Walsh on 24/04/2015.
//
//

#import "BeanTransitionManagerGenerator.h"

@implementation BeanTransitionManagerGenerator

+ (BeanTransitionManager *)transitionManagerConfiguredForCell:(id<BeanTransitionManagerCellExpanding>)cell
                                                withIndexPath:(NSIndexPath *)indexPath
                                             onCollectionView:(UICollectionView *)collectionView
                                              containedInView:(UIView*)view
                                                  andDuration:(NSTimeInterval)duration
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.cellImageView.image];
    
    CGPoint origin_point  =  [collectionView cellForItemAtIndexPath:indexPath].frame.origin;
    CGSize  size_of_view  =  cell.cellImageView.frame.size;
    CGRect  view_rect     =  CGRectMake(origin_point.x, origin_point.y+64, size_of_view.width, size_of_view.height);
    
    imageView.frame = [view convertRect:view_rect toView:view];
    [collectionView addSubview:imageView];
    
    BeanTransitionManager *transitionManager = [[BeanTransitionManager alloc] init];
    return transitionManager;
}

@end
