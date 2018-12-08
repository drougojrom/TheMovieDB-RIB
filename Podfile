use_frameworks!
platform :ios, '11.0'
inhibit_all_warnings!

def common_pods
    pod 'MBProgressHUD', '~> 1.0.0'
    pod 'RIBs', '~> 0.9'
    pod 'RxCocoa', '~> 4.0.0'
end

def shared_pods
    pod 'Alamofire', '~> 4.7'
    pod 'SwiftyJSON', '~> 4.0'
    pod 'Kingfisher'
    pod 'RealmSwift'
end

target 'themoviedb_pof' do
    common_pods
    shared_pods
end

target 'themoviedb_pofTests' do
    shared_pods
end
