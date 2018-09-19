#
# Be sure to run `pod lib lint FlagPhoneNumber.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'FlagPhoneNumber'
s.version          = '0.6.1'
s.summary          = 'A formatted phone number UITextField with country flag picker.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
FlagPhoneNumber is a phone number textfield that allows you to choose the country code thanks to a picker. It uses libPhoneNumber to format the number in the textfield according to country code.
DESC

s.homepage         = 'https://github.com/chronotruck/FlagPhoneNumber'
#s.screenshots     = 'https://github.com/chronotruck/FlagPhoneNumber/blob/master/Screenshot/screenshot.gif'
s.license          = { :type => 'Apache License 2.0', :file => 'LICENSE' }
s.author           = { 'Aurélien Grifasi' => 'aurelien.grifasi@chronotruck.com' }
s.source           = { :git => 'https://github.com/chronotruck/FlagPhoneNumber.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '8.0'

s.source_files = 'FlagPhoneNumber/**/*.swift'
s.resource_bundles = {'FlagPhoneNumber' => ['FlagPhoneNumber/Resources/**/*']}

#s.resource_bundles = {
#'FlagPhoneNumber' => ['FlagPhoneNumber/Assets/*']
#}

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'

s.dependency 'libPhoneNumber-iOS'
#s.xcconfig = { 'SWIFT_VERSION' => '4.0' }

end
