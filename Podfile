# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'Petcare' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Petcare

  pod 'CZPicker'
  pod 'DatePickerDialog'
  pod 'CKCircleMenuView', '~> 0.3'
  pod 'EFCircularSlider'

  target 'PetcareTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PetcareUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'Petcare WatchKit App' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Petcare WatchKit App

end

target 'Petcare WatchKit Extension' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Petcare WatchKit Extension

end

post_install do |installer|

    installer.pods_project.targets.each do |target|

            target.build_configurations.each do |config|

                        config.build_settings['SWIFT_VERSION'] = '3.0'

            end
    end

end
