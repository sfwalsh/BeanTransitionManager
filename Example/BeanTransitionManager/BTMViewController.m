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
        _beanTransitioningManager = [[BeanTransitionManager alloc] initWithTransitionDuration:0.5];
    }
    
    return _beanTransitioningManager;
}

- (NSMutableArray *)photos
{
    if(!_photos){
        
        _photos = [[NSMutableArray alloc] init];
        
        BTMPhoto *photo = [[BTMPhoto alloc] init];
        photo.photoTitle = @"A lovely garden";
        photo.photoImage = [UIImage imageNamed:@"flowers"];
        
        [_photos addObject:photo];
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
        [self.beanTransitioningManager setExpandingImageView:cell.cellImageView];
        
        destinationViewController.transitioningDelegate = self.beanTransitioningManager;
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
