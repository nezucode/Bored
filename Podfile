platform :ios, '16.2'

target 'Bored' do
  use_frameworks!

 pod 'FirebaseCore'
 pod 'FirebaseAuth'
 pod 'FirebaseFirestore'
 pod 'FirebaseStorage'
 
end

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET']
  end
 end
end
