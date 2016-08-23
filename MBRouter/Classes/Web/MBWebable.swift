//
//  MBWebable.swift
//  Pods
//
//  Created by Perry on 16/8/9.
//
//

import Foundation
import UIKit
import Alamofire

extension NSURLRequest {
    internal func targetRequest(nativeParams:[NSObject : AnyObject]) -> NSURLRequest {
        var request = self
        if let URL = URL {
            var params = URL.parameters().params
            for (k, v) in nativeParams {
                params.updateValue(v as! String, forKey: k as! String)
            }
            var hostport = URL.host!
            if let port = URL.port {
                hostport += ":" + port.stringValue
            }
            request = NSMutableURLRequest(URL: NSURL(scheme: URL.scheme, host: hostport, path: URL.path!)!)
            let encodeRequest = ParameterEncoding.URL.encode(request, parameters: params)
            request = encodeRequest.0
        }
        return request
    }
}

extension NSURL {
    public func routeType(webView:UIWebView, request:NSURLRequest) -> MBRouteType {
        return MBRouteType(type: parameters().type, params:parameters().params, target: parameters().target, webView: webView, request: request)
    }
    
    private func parameters() -> (type:String, target:String, params:[String : String]) {
        var params:[String : String] = [:]
        var target = ""
        var type = ""
        
        if let items = query?.componentsSeparatedByString("&") {
        for item in items {
            let keyAndValue = item.componentsSeparatedByString("=")
            if  2 == keyAndValue.count {
                if MBConfig.config().get(.URLFIELDTARGET) == keyAndValue[0] {
                    target = keyAndValue[1]
                } else if MBConfig.config().get(.URLFIELDTYPE) == keyAndValue[0] {
                    type = keyAndValue[1]
                } else {
                    params[keyAndValue[0]] = keyAndValue[1]
                }
            }
        }
        }
        return (type:type, target:target, params:params)
    }
}

extension MBWebContainer : UIWebViewDelegate{
    public func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return (request.URL?.routeType(webView, request:request).route())!
    }
}

extension MBWebable {
    public func loadRequest(url:String) {
        let webView = createWebView()
        webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
    }
    
    private func createWebView() -> UIWebView {
        if webContainer.subviews.count == 1 {
            if let webView = webContainer.subviews[0] as? UIWebView {
                return webView
            }
        }
        let webView = UIWebView()
        webView.delegate = webContainer
        webContainer.addMBSubView(webView, insets: UIEdgeInsetsZero)
        return webView
    }
}

public class MBWebContainer : UIView {
    
}

public protocol MBWebable {
    func loadRequest(url:String)

    var webContainer:MBWebContainer! { get }
}
