Pod::Spec.new do |s|
  s.name         = "SwiftyChevron"
  s.version      = "1.0.0"
  s.summary      = "An animated chevron view in full Swift."
  s.description  = <<-DESC
			An animated chevron view in full Swift.
                   DESC
  s.homepage     = "https://github.com/iMac0de/SwiftyChevron"
  s.license      = "MIT"
  s.author       = { "iMac0de" => "contact@jeremy-peltier.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/iMac0de/SwiftyChevron.git", :tag => "#{s.version}" }
  s.source_files  = "SwiftyChevron", "SwiftyChevron/*.{h,m,swift}"
end

