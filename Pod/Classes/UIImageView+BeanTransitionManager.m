//
//  UIImageView+BeanTransitionManager.m
//  Pods
//
//  Created by Stephen Walsh on 23/04/2015.
//
//

#import "UIImageView+BeanTransitionManager.h"

@implementation UIImageView (BeanTransitionManagerConvienence)

- (void)expandToFullscreenWithDuration:(NSTimeInterval)duration
{
    NSArray *fullscreenConstraints = [self fullscreenConstraintsOnView:self.superview];
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [self layoutIfNeeded];
        [self.superview addConstraints:fullscreenConstraints];
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)destroyAllConstraintsAndAlignToView:(UIView *)view
{
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth || constraint.firstAttribute == NSLayoutAttributeHeight) {
            [self removeConstraint:constraint];
        }
    }
    
    self.frame = view.frame;
}

- (NSArray *)fullscreenConstraintsOnView:(UIView*)view
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *heightConstraint =[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    NSLayoutConstraint *constraintX =[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *constraintY =[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    return @[widthConstraint, heightConstraint, constraintX, constraintY];
}

@end
