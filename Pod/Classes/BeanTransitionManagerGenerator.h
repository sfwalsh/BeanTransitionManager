//
//  BeanTransitionManagerGenerator.h
//  Pods
//
//  Created by Stephen Walsh on 24/04/2015.
//
//

#import <Foundation/Foundation.h>
#import "BeanTransitionManager.h"



@interface BeanTransitionManagerGenerator : NSObject

+ (BeanTransitionManager *)transitionManagerConfiguredForCell:(id<BeanTransitionManagerCellExpanding>)cell
                                                withIndexPath:(NSIndexPath*)indexPath
                                             onCollectionView:(UICollectionView*)collectionView
                                              containedInView:(UIView*)view
                                                  andDuration:(NSTimeInterval)duration;

@end
