# BeanTransitionManager

[![CI Status](http://img.shields.io/travis/Stephen Walsh/BeanTransitionManager.svg?style=flat)](https://travis-ci.org/Stephen Walsh/BeanTransitionManager)
[![Version](https://img.shields.io/cocoapods/v/BeanTransitionManager.svg?style=flat)](http://cocoapods.org/pods/BeanTransitionManager)
[![License](https://img.shields.io/cocoapods/l/BeanTransitionManager.svg?style=flat)](http://cocoapods.org/pods/BeanTransitionManager)
[![Platform](https://img.shields.io/cocoapods/p/BeanTransitionManager.svg?style=flat)](http://cocoapods.org/pods/BeanTransitionManager)


## Description
BeanTransitionManager is a means for expanding UIImageViews into detail views in a way similar to that used in the Pinterest iOS app.

![Alt text](http://i.imgur.com/lEdyeAX.gif?1 "Demo")



## Usage
To run the example project, clone the repo, and run `pod install` from the Example directory first.

Implementing the transition effect is quite easy:

The source view controller should store a BeanTransitionManager property and initialise it using `_beanTransitioningManager = [[BeanTransitionManager alloc] initWithExpandingImageView:self.imageView andTransitionDuration:1.0];`
where the expandingImageView property is the imageView that you want to expand into the destination view controller.

The `expandingImageView` property of the BeanTransitionManager can be updated as need be using `[self.beanTransitioningManager updateExpandingImageView:imageView]`.
A convienence method `- (void)updateExpandingImageViewWithCell:atIndexPath:inCollectionView:onView:andDuration:` for expanding UICollectionViewCells has also been included. A UICollectionViewCell subclass passed into this method must adhere to the `BeanTransitionManagerCellExpanding` protocol.

When segueing to the destination view controller assign the beanTransitioningManager property to the destination view controller's transitioning delegate:
`destinationViewController.transitioningDelegate = self.beanTransitioningManager;`

The destination view controller must adhere to the `BeanTransitionManagerDelegate` protocol.
This protocol only requires one readonly property `delegateContentImageView` which should return the destination imageView.

## Requirements
iOS 7 or later.


## Installation
BeanTransitionManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "BeanTransitionManager"
```

## Author

Stephen Walsh, sw7891@hotmail.com

## License

BeanTransitionManager is available under the MIT license. See the LICENSE file for more info.
