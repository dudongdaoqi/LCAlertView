Pod::Spec.new do |s|
  s.name             = "LCAlertView"
  s.version          = "2.1.0"
  s.summary          = "LCAlertView like syetem" 
  s.description      = <<-DESC
                       AlertView like system
                       DESC
  s.homepage         = "https://github.com/dudongdaoqi/LCAlertView"
  s.license          = 'MIT'
  s.author           = { "xulicheng" => "dudongdaoqi@gmail.com" }
  s.source           = { :git => "https://github.com/dudongdaoqi/LCAlertView.git", :tag => "2.1.0" }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/LCAlertView/*'
  s.public_header_files = 'Pod/Classes/LCAlertView/*.h'
end