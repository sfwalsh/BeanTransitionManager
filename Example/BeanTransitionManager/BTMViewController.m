//
//  BTMViewController.m
//  BeanTransitionManager
//
//  Created by Stephen Walsh on 04/23/2015.
//  Copyright (c) 2014 Stephen Walsh. All rights reserved.
//

#import "BTMViewController.h"
#import "BeanTransitionManager.h"

static NSString * const kShowDetailIdentifier = @"showDetail";

@interface BTMViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *expandingImageView;
@property (nonatomic, strong) BeanTransitionManager *beanTransitioningManager;

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
        _beanTransitioningManager = [[BeanTransitionManager alloc] initWithExpandingImageView:self.expandingImageView andTransitionDuration:0.50];
    }
    
    return _beanTransitioningManager;
}


#pragma mark - navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:kShowDetailIdentifier]) {
        UIViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.transitioningDelegate = self.beanTransitioningManager;
    }
}
@end
