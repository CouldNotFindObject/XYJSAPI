Pod::Spec.new do |s|
  s.name             = 'XYJSAPI'
  s.version          = '0.1.0'
  s.summary          = 'A short description of XYJSAPI.'


  s.description      = <<-DESC
Add long description of the pod here.Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/CouldNotFindObject/XYJSAPI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CouldNotFindObject' => '1848184115@qq.com' }
  s.source           = { :git => 'https://github.com/CouldNotFindObject/XYJSAPI.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'XYJSAPI/Classes/**/*'
  
  # s.resource_bundles = {
  #   'XYJSAPI' => ['XYJSAPI/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
