#
# Be sure to run `pod lib lint HLCustomTransitions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HLCustomTransitions'
  s.version          = '0.1.0'
  s.summary          = '一行代码实现自定义多个方向的转场动画'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    一行代码实现自定义多个方向的转场动画 无耦合 高效率转场 稳定性好
                       DESC

  s.homepage         = 'https://github.com/DargonLee/HLCustomTransitions'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DargonLee' => '2461414445@qq.com' }
  s.source           = { :git => 'https://github.com/DargonLee/HLCustomTransitions.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HLCustomTransitions/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HLCustomTransitions' => ['HLCustomTransitions/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
