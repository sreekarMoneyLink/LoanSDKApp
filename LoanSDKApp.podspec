Pod::Spec.new do |spec|
  spec.name         = "LoanSDKApp"
  spec.version      = "1.0.0"
  spec.summary      = "This SDK Provides Loan Management Service."
  spec.description  = "User can apply for a loan and track the status of it."

  # Corrected Homepage and Source URLs to HTTPS
  spec.homepage     = "https://github.com/sreekarMoneyLink/LoanSDKApp"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }  # Skipping LICENSE file reference for now
  spec.author       = { "sreekarMoneyLink" => "sreekar.pv@montra.org" }

  # Corrected source to use HTTPS instead of SSH
  spec.source       = { :git => "https://github.com/sreekarMoneyLink/LoanSDKApp.git", :tag => "#{spec.version}" }

  # iOS deployment target
  spec.ios.deployment_target = '13.0'

  # Corrected source files pattern
  spec.source_files = 'LoanSDKApp/**/*.{swift,h,m}'

  # Exclude files
  spec.exclude_files = "Classes/Exclude"

  # Dependency
  spec.dependency 'Alamofire', '~> 5.9.1'

  # Build settings
  spec.swift_version = '5.0'
end