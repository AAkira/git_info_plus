#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint git_info_plus.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'git_info_plus'
  s.version          = '0.0.1'
  s.summary          = 'Get git information from within the Flutter application'
  s.description      = <<-DESC
Get git information from within the Flutter application
                       DESC
  s.homepage         = 'http://github.com/aakira/git_info_plus'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'AAkira' => 'developer.a.akira@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
