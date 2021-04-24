#if canImport(UIKit)

import UIKit

#endif

public extension UIApplication {
    
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
}
