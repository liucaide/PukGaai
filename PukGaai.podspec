
Pod::Spec.new do |s|
  s.name             = 'PukGaai'
  s.version          = '0.1.0'
  s.summary          = 'A 第三方资源.'
  s.description      = <<-DESC
  TODO: A 第三方资源，项目配置组件.
                       DESC

  s.homepage         = 'https://github.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => '' }
  

  s.ios.deployment_target = '9.0'
  s.swift_version = ['4.0', '4.2', '5.0']
  s.static_framework = true
  
  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |core|
    core.dependency 'CaamDau'
  end

  s.subspec 'Pay' do |pay|
    pay.dependency 'PukGaai/AliPay'
    pay.dependency 'PukGaai/WechatPay'
    pay.dependency 'PukGaai/UnionPay'
  end

  s.subspec 'AliPay' do |ali|
    ali.source_files = 'PukGaai/PGPay/AliPay/Classes/**/*', 'PukGaai/PGPay/PGPay.swift'
    ali.resource = 'PukGaai/PGPay/AliPay/Frameworks/*.bundle'
    ali.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '"-ObjC"' }
    ali.ios.library = 'c++', 'z'
    ali.frameworks = 'CoreMotion', 'CoreGraphics', 'CoreText', 'QuartzCore', 'CoreTelephony', 'SystemConfiguration', 'CFNetwork'
    ali.ios.vendored_frameworks = 'PukGaai/PGPay/AliPay/Frameworks/*.framework'
    ali.preserve_paths = 'PukGaai/PGPay/AliPay/Frameworks/module.modulemap'
  end

  s.subspec 'WechatPay' do |wx|
    wx.source_files = 'PukGaai/PGPay/WXPay/Classes/**/*', 'PukGaai/PGPay/WXPay/Frameworks/*.h', 'PukGaai/PGPay/PGPay.swift'
    wx.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
    wx.frameworks = 'SystemConfiguration', 'CFNetwork', 'Security', 'CoreTelephony', 'CoreGraphics'
    wx.ios.library = 'c++', 'z', 'sqlite3.0'
    wx.vendored_libraries = 'PukGaai/PGPay/WXPay/Frameworks/*.a'
    wx.public_header_files = 'PukGaai/PGPay/WXPay/Frameworks/*.h'
  end

  s.subspec 'UnionPay' do |un|
    un.source_files = 'PukGaai/PGPay/UnionPay/Classes/**/*', 'PukGaai/PGPay/UnionPay/Frameworks/*.h', 'PukGaai/PGPay/PGPay.swift'
    un.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
    un.frameworks = 'SystemConfiguration', 'CFNetwork'
    un.ios.library = 'c++', 'z'
    un.vendored_libraries = 'PukGaai/PGPay/UnionPay/Frameworks/*.a'
    un.public_header_files = 'PukGaai/PGPay/UnionPay/Frameworks/*.h'
  end

  s.dependency 'CaamDau/Core'
  s.dependency 'CaamDau/AppDelegate'
end
