platform :ios, '7.0'

pod 'AFNetworking'
pod 'FMDB'
pod 'SVProgressHUD'
pod 'libqrencode'
pod 'ReactiveCocoa'

post_install do |installer|
    installer.project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ARCHS'] = "armv7"
        end
    end
end