
Pod::Spec.new do |s|
  s.name             = 'PGPay'
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
  s.swift_version = '5.0'
  s.static_framework = true

  s.default_subspec = 'Core'
  s.source_files = 'PGPay/PGPay.swift'
  
  s.subspec 'Core' do |core|
    core.dependency 'PGPay/Ali'
    core.dependency 'PGPay/Wechat'
    core.dependency 'PGPay/Union'
  end

  s.subspec 'Ali' do |ali|
    ali.source_files = 'PGPay/AliPayDepend/Classes/**/*', 'Pods/AlipaySDK-iOS/AlipaySDK.framework/Headers/*.h'
    ali.dependency 'AlipaySDK-iOS'
    
#    ali.xcconfig = {
#      'OTHER_LDFLAGS' => '-ObjC',
#      'HEADER_SEARCH_PATHS' => '"$(PODS_ROOT)/../PGPay/AliPayDepend/Signer"',
#      'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/../PGPay/AliPayDepend/Signer"'
#    }
#    ali.frameworks = 'CoreMotion', 'CoreGraphics', 'CoreText', 'QuartzCore', 'CoreTelephony', 'SystemConfiguration', 'CFNetwork'
#    ali.ios.library = 'c++', 'z'
#    ali.vendored_libraries = 'PGPay/AliPayDepend/Signer/Frameworks/*.a'
#    ali.public_header_files = 'PGPay/AliPayDepend/Signer/**/*.h'
  end

  s.subspec 'Wechat' do |wx|
    wx.source_files = 'PGPay/WXPayDepend/Classes/**/*', 'Pods/WechatOpenSDK/WeChatSDK1.8.4/*.h'
    wx.dependency 'WechatOpenSDK'
  end

  s.subspec 'Union' do |un|
    un.source_files = 'PGPay/UnionPay/Classes/**/*', 'PGPay/UnionPay/Frameworks/*.h'
    un.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
    un.frameworks = 'SystemConfiguration', 'CFNetwork'
    un.ios.library = 'c++', 'z'
    un.vendored_libraries = 'PGPay/UnionPay/Frameworks/*.a'
    un.public_header_files = 'PGPay/UnionPay/Frameworks/*.h'
  end

  s.dependency 'CaamDau'
end
