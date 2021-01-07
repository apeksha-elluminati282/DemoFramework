Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '10.0'
s.name = "DemoFramework"
s.summary = "Demo framework lets a user select an ice cream flavor."
s.requires_arc = true

# 2
s.version = "1.0.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Apeksha Mehta" => "apeksha.elluminati@gmail.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/apeksha-elluminati282/DemoFramework"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/apeksha-elluminati282/DemoFramework.git", 
             :tag => "#{s.version}" }

# 7
s.framework = "Foundation"
#s.dependency 'Alamofire', '~> 4.7'
#s.dependency 'MBProgressHUD', '~> 1.1.0'

# 8
s.source_files = "DemoFramework/**/*.{h,swift}"

# 9
#s.resources = "Classes/**/*"

# 10
s.swift_version = "5.0"

end