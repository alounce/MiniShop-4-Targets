platform :ios, '11.0'

#########################################################

def install_common_app_pods
  pod 'Alamofire'
  pod 'SwiftLint'
end

#########################################################

target 'Stock' do
  use_frameworks!

  # Common pods 
  install_common_app_pods
  
  # Stock specific pods going here:
  pod 'Fabric'
  pod 'Crashlytics'

 
  target 'StockTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'OHHTTPStubs/Swift', '= 6.1.0'
  end

end

#########################################################

target 'Shop' do
  use_frameworks!

  # Common pods 
  install_common_app_pods
  
  # Shop specific pods going here:
  pod 'Toaster'

end

#########################################################
