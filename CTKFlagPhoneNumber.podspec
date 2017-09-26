#
# Be sure to run `pod lib lint CTKFlagPhoneNumber.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'CTKFlagPhoneNumber'
s.version          = '0.1.12'
s.summary          = 'A formatted phone number UITextField with country flag picker.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
CTKFlagPhoneNumber is a phone number textfield that allows you to choose the country code thanks to a picker. It uses libPhoneNumber to format the number in the textfield according to country code.
DESC

s.homepage         = 'https://github.com/chronotruck/CTKFlagPhoneNumber'
#s.screenshots      = 'https://github.com/chronotruck/CTKFlagPhoneNumber/blob/master/Screenshot/screenshot.gif'
s.license          = { :type => 'Apache License 2.0', :file => 'LICENSE' }
s.author           = { 'Aurélien Grifasi' => 'aurelien.grifasi@chronotruck.com' }
s.source           = { :git => 'https://github.com/chronotruck/CTKFlagPhoneNumber.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '8.0'

s.source_files = 'CTKFlagPhoneNumber/**/*.swift'
s.resource_bundles = {'CTKFlagPhoneNumber' => ['CTKFlagPhoneNumber/Resources/**/*']}

#s.resource_bundles = {
#'CTKFlagPhoneNumber' => ['CTKFlagPhoneNumber/Assets/*']
#}

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'

s.dependency 'libPhoneNumber-iOS'
s.dependency 'FlagKit'
#s.xcconfig = { 'SWIFT_VERSION' => '3.0' }

end
