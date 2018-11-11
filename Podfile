platform :ios, '12.0'

def rx_swift
    pod 'RxSwift'
end

def rx_cocoa
    pod 'RxCocoa'
end


target 'GistViewer' do
  use_frameworks!
  rx_cocoa
  rx_swift
  pod 'Cartography'
  pod 'Kingfisher'

end

target 'Domain' do
    use_frameworks!
    rx_cocoa
    rx_swift
    
end

target 'NetworkPlatform' do
    use_frameworks!
    rx_swift
    pod 'Alamofire'
    pod 'RxAlamofire'
    pod 'Realm'
    pod 'RxRealm'
    pod 'QueryKit'
    pod 'RealmSwift'
    
end

target 'RealmPlatform' do
    use_frameworks!
    rx_swift
    pod 'RxRealm'
    pod 'QueryKit'
    pod 'RealmSwift'
    pod 'Realm'
    
end
