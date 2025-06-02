#if canImport(UIKit)

import UIKit
import SystemConfiguration

#endif

public extension UIApplication {
    
    /// Application key window
    static var keyWindow: UIWindow? {
        UIApplication.shared
            .connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .filter(\.isKeyWindow)
            .first
    }
    
    var visibleKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter({
                return $0.activationState == .foregroundActive ||
                $0.activationState == .background ||
                $0.activationState == .foregroundInactive
            })
            .compactMap({$0 as? UIWindowScene})
            .sorted(by: {
                $0.activationState.rawValue < $1.activationState.rawValue
            })
            .first?.windows
            .filter({$0.isKeyWindow}).first
    }
    
    func makeSnapshot() -> UIImage? {
        return visibleKeyWindow?.layer.makeSnapshot()
    }
    
    
    static func getTopViewController(base: UIViewController? = nil) -> UIViewController? {
        let base = base ?? UIApplication.shared.visibleKeyWindow?.rootViewController
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
    /// Open application settings
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString), canOpenURL(url) {
            if #available(iOS 10.0, *) {
                open(url, options: [:], completionHandler: nil)
            } else {
                openURL(url)
            }
        }
    }
    
    /// Opens application sheet for phonen number
    func openPhone(calling number: String) {
        if let url = URL(string: "tel://" + number) {
            if #available(iOS 10.0, *) {
                open(url, options: [:], completionHandler: nil)
            } else {
                openURL(url)
            }
        }
    }
    
    /// Find My Facebook ID: https://findmyfbid.com/
    /// - Parameters:
    ///   - name: Facebook name
    ///   - id: Facebook ID
    func openFacebook(name: String?, id: String?) {
        if let facebookID = id,
           let facebookURL = URL(string: "fb://profile/\(facebookID)"),
           UIApplication.shared.canOpenURL(facebookURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(facebookURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(facebookURL)
            }
        }
        else if let name = name {
            UIViewController.getCurrentViewController()?.pushSafariViewController(urlString: "https://www.facebook.com/" + name)
        }
    }
    
    /// Launches the Instagram app and loads the Instagram user
    /// - Parameter name: Instagram username
    func openInstagram(name: String?) {
        if let ins = name {
            if let instagramURL = URL(string: "instagram://user?username=\(ins)"),
               UIApplication.shared.canOpenURL(instagramURL) {
                if #available(iOS 10.0, *) {
                    open(instagramURL, options: [:], completionHandler: nil)
                } else {
                    openURL(instagramURL)
                }
            } else {
                UIViewController.getCurrentViewController()?.pushSafariViewController(urlString: "https://www.instagram.com/" + ins)
            }
        }
    }
    
    /// Launches the Instagram app and loads the Instagram user
    /// - Parameter name: Instagram username
    func openInstagram(media: String?) {
        if let media = media {
            if let instagramURL = URL(string: "instagram://media?id=\(media)"),
               UIApplication.shared.canOpenURL(instagramURL) {
                if #available(iOS 10.0, *) {
                    open(instagramURL, options: [:], completionHandler: nil)
                } else {
                    openURL(instagramURL)
                }
            } else {
                UIViewController.getCurrentViewController()?.pushSafariViewController(urlString: "https://www.instagram.com/" + media)
            }
        }
    }
    
    /// Open a map app with the given query. Orders: Google Map -> Apple Map
    ///
    /// - Parameter query: The query to search on the map.
    func openExternalMapApp(query: String) {
        if let string = "comgooglemaps://?q=\(query)&zoom=13".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let googleMapURL = URL(string: string),
           UIApplication.shared.canOpenURL(googleMapURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(googleMapURL)
            } else {
                dprint("Error: opening google maps url with query: \(query)")
            }
            return
        }
        if let string = "https://maps.apple.com/?address=\(query)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: string), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                dprint("Error: opening google maps url with query: \(query)")
            }
            return
        }
    }
    
    /// Checks if the application is connected to the internet via `SystemConfiguration`
    var isConnectedToNetwork: Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        guard SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) else {
            dprint("Network is not reachable.")
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}
