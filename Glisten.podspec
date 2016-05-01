
Pod::Spec.new do |s|
  s.name          = "Glisten"
  s.version       = "0.0.2"
  s.summary       = "Who left the cap off my [bleeping] Glisten!?"
  s.homepage      = "https://github.com/comyarzaheri/Glisten"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = { "Comyar Zaheri" => "" }
  s.ios.deployment_target = "8.0"
  s.source        = { :git => "https://github.com/comyarzaheri/Glisten.git", :tag => s.version.to_s }
  s.source_files  = "Glisten/*.swift"
  s.requires_arc  = true
  s.module_name	  = "Glisten"
end
