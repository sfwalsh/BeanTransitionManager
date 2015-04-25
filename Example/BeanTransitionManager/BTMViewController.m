//
//  BTMViewController.m
//  BeanTransitionManager
//
//  Created by Stephen Walsh on 04/23/2015.
//  Copyright (c) 2014 Stephen Walsh. All rights reserved.
//

#import "BTMViewController.h"
#import "BeanTransitionManager.h"
#import "BTMPhoto.h"
#import "BTMPhotoCellCollectionViewCell.h"
#import "BTMDetailViewController.h"
#import "BeanTransitionManagerGenerator.h"

static NSString * const kShowDetailIdentifier = @"showDetail";
static NSString * const kCellIdentifier = @"photoCell";
@interface BTMViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) BeanTransitionManager *beanTransitioningManager;
@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation BTMViewController


#pragma mark - setup
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - lazy loaders
- (BeanTransitionManager *)beanTransitioningManager
{
    if (!_beanTransitioningManager) {
        _beanTransitioningManager = [[BeanTransitionManager alloc] initWithTransitionDuration:1];
    }
    
    return _beanTransitioningManager;
}

- (NSMutableArray *)photos
{
    if(!_photos){
        
        _photos = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 40; i++) {
            BTMPhoto *photo = [[BTMPhoto alloc] init];
            photo.photoTitle = @"A lovely garden";
            photo.photoImage = [UIImage imageNamed:@"flowers"];
            
            [_photos addObject:photo];
        }
    }
    return _photos;
}


#pragma mark - navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:kShowDetailIdentifier]) {
        
        BTMDetailViewController *destinationViewController = (BTMDetailViewController*) segue.destinationViewController;
        
        NSIndexPath *indexPath = self.collectionView.indexPathsForSelectedItems.firstObject;
        destinationViewController.photo = self.photos[indexPath.item];
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
        
        BTMPhotoCellCollectionViewCell* cell = (BTMPhotoCellCollectionViewCell*) [self.collectionView cellForItemAtIndexPath:indexPath];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.cellImageView.image];
        imageView.clipsToBounds = YES;
        CGPoint origin_point  =  [self.collectionView cellForItemAtIndexPath:indexPath].frame.origin;
        CGSize  size_of_view  =  cell.cellImageView.frame.size;
        CGRect  view_rect     =  CGRectMake(origin_point.x, origin_point.y, size_of_view.width, size_of_view.height);
        
        
//        imageView.frame = view_rect;
        imageView.frame = [self.collectionView convertRect:view_rect toView:self.view];
        [self.view addSubview:imageView];
        [self.beanTransitioningManager updateExpandingImageView:imageView];
        
        
//        [self.beanTransitioningManager updateExpandingImageViewWithCell:cell atIndexPath:indexPath inCollectionView:self.collectionView onView:self.view andDuration:5.0];
        
        destinationViewController.transitioningDelegate = self.beanTransitioningManager;
//        [imageView removeFromSuperview];
    }
}


#pragma mark - UICollectionViewDatasource and delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BTMPhotoCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    [cell setupViewWithPhoto:self.photos[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kShowDetailIdentifier sender:self];
}

@end
