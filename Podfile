# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'Chat App' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Chat App

pod 'Firebase'

#Authentication module
pod 'Firebase/Auth'

#Realtime database module
pod 'Firebase/Database'

pod 'SVProgressHUD'

pod 'ChameleonFramework'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
        end
    end
end
