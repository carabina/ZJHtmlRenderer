Pod::Spec.new do |s|
  s.name         = "ZJHtmlRenderer"
  s.version      = "0.0.1"
  s.summary      = "A HTML renderer for iOS."
  s.ios.deployment_target = "7.0"
  s.homepage     = "https://github.com/evanzhou0319/ZJHtmlRenderer"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "EvanZhou0319" => "evanzhou0319@qq.com" }
  s.source       = { :git => "https://github.com/EvanZhou0319/ZJHtmlRenderer.git", :tag => s.version }
  s.source_files  = "ZJHtmlRenderer/*"
  s.framework  = "UIKit"
  s.requires_arc = true
end
