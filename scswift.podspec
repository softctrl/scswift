#
# Be sure to run `pod lib lint scswift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'scswift'
  s.version          = '0.1.0'
  s.summary          = 'It is just a library to reduce the time cost of a Swift ios developmento project.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
I do have a huge library with Obj-c. But i am porting this code for Swift. Here we do have a lot of facilities that may help in any iOS project.
                       DESC

  s.homepage         = 'https://softctrl.github.io/scswift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'carlostimoshenkorodrigueslopes@gmail.com' => 'carlostimoshenkorodrigueslopes@gmail.com' }
  s.source           = { :git => 'https://github.com/softctrl/scswift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.3'

  s.source_files = 'scswift/Classes/**/*'
  
  # s.resource_bundles = {
  #   'scswift' => ['scswift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

  s.dependency 'RealmSwift', '~> 2.8.3'
  s.dependency 'XCGLogger', '~> 5.0.1'
  s.dependency 'PopupDialog', '~> 0.5.4'
  s.dependency 'Socket.IO-Client-Swift', '~> 8.3.0'

end
