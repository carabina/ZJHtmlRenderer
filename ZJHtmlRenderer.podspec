Pod::Spec.new do |s|
s.name         = "ZJHtmlRenderer"
s.version      = "0.0.1"
s.license      = "MIT"
s.summary      = "A HTML renderer for iOS."
s.homepage     = "https://github.com/evanzhou0319/ZJHtmlRenderer"
s.authors      = { "evan" => "evanzhou0319@qq.com" }
s.source       = { :git => "https://github.com/evanzhou0319/ZJHtmlRenderer.git", :tag => s.version }
s.platform     = :ios, '7.0'
s.requires_arc = true
s.source_files = "ZJHtmlRenderer/ZJHtmlRenderer.{h,m}"
s.framework  = "UIKit"
end
