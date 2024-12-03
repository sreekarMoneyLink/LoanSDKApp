Pod::Spec.new do |s|
  s.name         = 'LoanSDKApp'
  s.version      = '1.0.0'
  s.summary      = 'This SDK Provides Loan Management Service .'
  s.description  = 'user can apply for loan and track the status of it'
  s.homepage     = 'https://github.com/username/LoanSDKApp'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Your Name' => 'sreekar.pv@montra.org' }
  s.source       = { :git => 'https://github.com/username/MySDK.git', :tag => '1.0.0' }
  s.ios.deployment_target = '13.0'
  
  # Framework files
  s.source_files = 'MySDK/**/*.{swift,h,m}'
  s.resources    = 'MySDK/Resources/*'
  
  # Dependency
  s.dependency 'Alamofire', '~> 5.9.1'
  
  # Build settings
  s.swift_version = '5.0'
end
