//
//  MBWeber.swift
//  Pods
//
//  Created by Perry on 16/8/9.
//
//

import Foundation
import UIKit
import Routable

enum MBTargetType {
    case Native(url:String)
    case Web(url:String)
    case None
    
    func route() -> Bool {
        switch self {
        case .Native(let url):
            Routable.sharedRouter().open(url)
            return false
        case .Web(let url):
            Routable.sharedRouter().openExternal(url)
            return true
        case .None:
            return true
        }
    }
}

extension NSURL {
    private func targetType() -> MBTargetType {
        if "web" == parameters().target {
            return .Web(url: self.absoluteString)
        } else {
            return .Native(url:routeURL())
        }
    }
    
    private func routeURI() -> String {
        var routeURI = ""
        routeURI += parameters().target
        for item in parameters().params.keys {
            routeURI += "/:" + item
        }
        return routeURI
    }
    
    private func routeURL() -> String {
        var routeURL = ""
        routeURL += parameters().target
        for item in parameters().params.keys {
            routeURL += "/" + parameters().params[item]!
        }
        return routeURL
    }
    
    private func parameters() -> (target:String, params:[String : String]) {
        var params:[String : String] = [:]
        var target = ""
        
        if let items = query?.componentsSeparatedByString("&") {
            for item in items {
                let keyAndValue = item.componentsSeparatedByString("=")
                if  2 == keyAndValue.count {
                    if "target" == keyAndValue[0] {
                        target = keyAndValue[1]
                    } else {
                        params[keyAndValue[0]] = keyAndValue[1]
                    }
                }
            }
        }
        return (target:target, params:params)
    }
}

extension UIViewController : UIWebViewDelegate{
    public func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return (request.URL?.targetType().route())!
    }
}

extension MBWebable {
    public func loadRequest(url:String) {
        let webView = UIWebView()
        if let controller = self as? UIViewController {
            webView.delegate = controller
            controller.view.addMBSubView(webView, insets: UIEdgeInsetsZero)
        }
        webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
    }
}

public protocol MBWebable {
    func loadRequest(url:String)
}
