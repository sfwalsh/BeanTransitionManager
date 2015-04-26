#
# Be sure to run `pod lib lint BeanTransitionManager.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "BeanTransitionManager"
  s.version          = "0.2.1"
  s.summary          = "A Pinterest style segue for expanding UIImageViews into detail views."
  s.description      = <<-DESC
                        BeanTransitionManager is a means for expanding UIImageViews into detail views in a way similar to that used in the Pinterest iOS app.

Please see the demo project included for example usage.
                       DESC
  s.homepage         = "https://github.com/sfwalsh/BeanTransitionManager"
  # s.screenshots     = "http://i.imgur.com/O05sIIV.gif"
  s.license          = 'MIT'
  s.author           = { "Stephen Walsh" => "sw7891@hotmail.com" }
  s.source           = { :git => "https://github.com/sfwalsh/BeanTransitionManager.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/Hapkido_ORourke'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'BeanTransitionManager' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
