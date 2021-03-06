//
//  BTMDetailViewController.m
//  BeanTransitionManager
//
//  Created by Stephen Walsh on 23/04/2015.
//  Copyright (c) 2015 Stephen Walsh. All rights reserved.
//

#import "BTMDetailViewController.h"

@interface BTMDetailViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *viewLabel;

@end

@implementation BTMDetailViewController


#pragma mark - setup
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.viewLabel.text = self.photo.photoTitle;
}


#pragma mark - lazy loaders
- (UIImageView *)delegateContentImageView
{
    return self.imageView;
}


#pragma mark - action listeners
- (IBAction)didTapShrinkButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
