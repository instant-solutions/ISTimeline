Pod::Spec.new do |s|
  s.name         = "ISTimeline"
  s.version      = "0.0.5"
  s.summary      = "ISTimeline is a simple timeline view written in Swift 2.2"
  s.homepage     = "https://github.com/instant-solutions/ISTimeline"

  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.author             = { "instant:solutions" => "office@instant-it.at" }
  s.social_media_url   = "https://www.facebook.com/instantsol"
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/instant-solutions/ISTimeline.git", :tag => "v#{s.version}" }
  s.source_files  = "ISTimeline/ISTimeline/**/*.{h,swift}"
end
