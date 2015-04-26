//
//  NonCollectionViewDemoViewController.m
//  BeanTransitionManager
//
//  Created by Stephen Walsh on 26/04/2015.
//  Copyright (c) 2015 Stephen Walsh. All rights reserved.
//

#import "NonCollectionViewDemoViewController.h"
#import "BeanTransitionManager.h"
#import "BTMDetailViewController.h"

static NSString * const kShowDetailIdentifier = @"showDetail";

@interface NonCollectionViewDemoViewController ()

@property (nonatomic, strong) BeanTransitionManager *beanTransitioningManager;
@property (weak, nonatomic) IBOutlet UIImageView *sourceImageView;

@end

@implementation NonCollectionViewDemoViewController


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
        _beanTransitioningManager = [[BeanTransitionManager alloc] initWithExpandingImageView:self.sourceImageView andTransitionDuration:1.05f];
    }
    
    return _beanTransitioningManager;
}


#pragma mark - action listeners
- (IBAction)growButtonTapped:(id)sender
{
    [self performSegueWithIdentifier:kShowDetailIdentifier sender:self];
}


#pragma mark - navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:kShowDetailIdentifier]) {
        
        BTMDetailViewController *destinationViewController = (BTMDetailViewController*) segue.destinationViewController;
        destinationViewController.transitioningDelegate = self.beanTransitioningManager;
    }
}


@end
