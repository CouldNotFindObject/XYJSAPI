Pod::Spec.new do |s|
  s.name             = 'XYJSAPI'
  s.version          = '0.1.2'
  s.summary          = 'XYJSAPI 是js桥'


  s.description      = <<-DESC
Add long description of the pod here.Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/CouldNotFindObject/XYJSAPI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CouldNotFindObject' => '1848184115@qq.com' }
  s.source           = { :git => 'https://github.com/CouldNotFindObject/XYJSAPI.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'XYJSAPI/Classes/JSAPIService/*.{h,m}'
  s.dependency 'AFNetworking'
  s.dependency 'MJExtension'
  s.dependency 'AMapLocation-NO-IDFA'
  s.requires_arc = true
  
  s.subspec 'Components' do |ss|
      ss.source_files = 'XYJSAPI/Classes/JSAPIService/Components/**/*'
  end
  
  s.subspec 'Controller' do |ss|
      ss.source_files = 'XYJSAPI/Classes/JSAPIService/Controller/**/*'
  end
  s.subspec 'Filter' do |ss|
      ss.source_files = 'XYJSAPI/Classes/JSAPIService/Filter/**/*'
  end
  s.subspec 'Lib' do |ss|
      ss.source_files = 'XYJSAPI/Classes/JSAPIService/Lib/**/*'
  end
  s.subspec 'Model' do |ss|
      ss.source_files = 'XYJSAPI/Classes/JSAPIService/Model/**/*'
  end
  s.subspec 'Service' do |ss|
      ss.source_files = 'XYJSAPI/Classes/JSAPIService/Service/**/*'
  end
  s.subspec 'Util' do |ss|
      ss.source_files = 'XYJSAPI/Classes/JSAPIService/Util/**/*'
  end
end
