//
//  MBRoutable.swift
//  Pods
//
//  Created by Perry on 16/8/12.
//
//

import Foundation
import Routable

public enum MBRouteType {
    case Native(params:[String : String], target:String)
    case AgentNative(params:[String : String], target:String)
    case AgentWeb(params:[String : String], target:String, webView:UIWebView, request:NSURLRequest)
    case Web
    case None
    
    func route() -> Bool {
        switch self {
        case .Native(let params, let target):
            MBRouter.router().open(MBConfig.config().get(.URINORMALPREFIX) + params.routeURI(target), url: MBConfig.config().get(.URINORMALPREFIX) + params.routeURL(target))
            return false
        case .AgentNative(let params, let target):
            
            MBRouter.router().open(MBConfig.config().get(.URINORMALPREFIX) + params.routeURI(target).native, url: MBConfig.config().get(.URINORMALPREFIX) + params.routeURL(target).native)
            
            MBRouter.router().setEnabled(MBConfig.config().get(.URICALLBACKPREFIX) + params.routeURI(target).native, enabled: true)
            
            Routable.sharedRouter().map(MBConfig.config().get(.URICALLBACKPREFIX) + params.routeURI(target).native, toCallback: { (nativeparams:[NSObject : AnyObject]!) in
                
                MBRouter.router().setEnabled(MBConfig.config().get(.URICALLBACKPREFIX) + params.routeURI(target).native, enabled: false)
                
                MBRouter.router().open(MBConfig.config().get(.URITARGETPREFIX) + params.routeURI(target).web + nativeparams.routeURI(""), url: MBConfig.config().get(.URITARGETPREFIX) + params.routeURL(target).web + nativeparams.routeURL(""))
            })
            
            return false
        case .Web:
            return true
        case .AgentWeb(let params, let target, let webView, let request):
            
            MBRouter.router().open(MBConfig.config().get(.URINORMALPREFIX) + params.routeURI(target).native, url: MBConfig.config().get(.URINORMALPREFIX) + params.routeURL(target).native)
            
            MBRouter.router().setEnabled(MBConfig.config().get(.URICALLBACKPREFIX) + params.routeURI(target).native, enabled: true)
            
            Routable.sharedRouter().map(MBConfig.config().get(.URICALLBACKPREFIX) + params.routeURI(target).native, toCallback: { (nativeparams:[NSObject : AnyObject]!) in
                
                MBRouter.router().setEnabled(MBConfig.config().get(.URICALLBACKPREFIX) + params.routeURI(target).native, enabled: false)
                
                webView.loadRequest(request.targetRequest(params))
            })
            return false
        case .None:
            return true
        }
    }
    
    init(type:String, params:[String : String], target:String, webView:UIWebView, request:NSURLRequest) {
        if MBConfig.config().get(.ULRFIELDTYPENATIVE) == type && false == target.isEmpty {
            self = .Native(params: params, target:target)
        } else if MBConfig.config().get(.ULRFIELDTYPEAGENTNATIVE) == type && false == target.isEmpty {
            self = .AgentNative(params: params, target: target)
        } else if MBConfig.config().get(.ULRFIELDTYPEWEB) == type {
            self = .Web
        } else if MBConfig.config().get(.ULRFIELDTYPEAGENTWEB) == type && false == target.isEmpty {
            self = .AgentWeb(params: params, target: target, webView:webView, request:request)
        } else {
            self = .None
        }
    }
}

extension Dictionary {
    public func routeURI(target:String) -> (web:String, native:String) {
        var web = ""
        var native = ""
        
        web += target
        native += target
        
        for key in self.keys {
            if let keyName = key as? String {
                if let value = self[key] as? String {
                    if MBConfig.config().get(.URLFIELDFILLTYPENATIVE) == value {
                        native += "/:" + keyName
                    } else {
                        web += "/:" + keyName
                    }
                }
            }
        }
        return (web:web, native:native)
    }
    
    public func routeURL(target:String) -> (web:String, native:String) {
        var web = ""
        var native = ""
        
        web += target
        native += target
        
        for key in self.keys {
            if let value = self[key] as? String {
                if MBConfig.config().get(.URLFIELDFILLTYPENATIVE) == value {
                    native += "/" + value
                } else {
                    web += "/" + value
                }
            }
        }
        return (web:web, native:native)
    }
    
    public func routeURL(target:String) -> String {
        var routeURL = ""
        routeURL += target
        for key in self.keys {
            if let value = self[key] as? String {
                routeURL += "/" + value
            }
        }
        return routeURL
    }
    
    public func routeURI(target:String) -> String {
        var routeURI = ""
        routeURI += target
        for key in self.keys {
            if let keyName = key as? String {
                routeURI += "/:" + keyName
            }
        }
        return routeURI
    }
}