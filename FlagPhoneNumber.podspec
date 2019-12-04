#
# Be sure to run `pod lib lint FlagPhoneNumber.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
	s.name             = 'FlagPhoneNumber'
	s.version          = '0.8.0'
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
	s.license          = { :type => 'Apache License 2.0', :file => 'LICENSE' }
	s.author           = { 'Aurélien Grifasi' => 'aurelien.grifasi@chronotruck.com' }
	s.source           = { :git => 'https://github.com/chronotruck/FlagPhoneNumber.git', :tag => s.version.to_s }

	s.ios.deployment_target = '8.0'
	s.source_files = 'Sources/**/*.swift'
	s.resource_bundles = {'FlagPhoneNumber' => ['Sources/Resources/**/*']}
	s.swift_version = '5.0'
	s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }

	s.subspec 'libPhoneNumberiOS' do |ss|
		ss.source_files = 'Sources/libPhoneNumber/**/*.{m,h}'
	end
end
