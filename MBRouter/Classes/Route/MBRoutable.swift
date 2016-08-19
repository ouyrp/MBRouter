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
    case Native(url:String)
    case AgentNative(params:[String : String], target:String)
    case AgentWeb(params:[String : String], target:String, webView:UIWebView, request:NSURLRequest)
    case Web
    case None
    
    func route() -> Bool {
        switch self {
        case .Native(let url):
            Routable.sharedRouter().open(url)
            return false
        case .AgentNative(let params, let target):
            if let controller = MBTargetMapper.shareInstance().get(target) {
                Routable.sharedRouter().open(params.routeURL(target).agent)
                let format = AGENTCALLBACK + params.routeURI(target).agent
                Routable.sharedRouter().map(format, toCallback: { (agentparams:[NSObject : AnyObject]!) in
                    let uri = TARGET + params.routeURI(target).origin + agentparams.routeURI("")
                    Routable.sharedRouter().map(uri, toController: controller)
                    let url = TARGET + params.routeURL(target).origin + agentparams.routeURL("")
                    Routable.sharedRouter().open(url)
                })
                return false
            } else {
                return true
            }
        case .Web:
            return true
        case .AgentWeb(let params, let target, let webView, let request):
            Routable.sharedRouter().open(params.routeURI(target).agent)
            let format = AGENTCALLBACK + params.routeURI(target).agent
            Routable.sharedRouter().map(format, toCallback: { (params:[NSObject : AnyObject]!) in
                webView.loadRequest(request.targetRequest(params))
            })
            return false
        case .None:
            return true
        }
    }
    
    init(type:String, params:[String : String], target:String, webView:UIWebView, request:NSURLRequest) {
        if "native" == type && "" != params.routeURL(target) {
            self = .Native(url: params.routeURL(target))
        } else if "agentnative" == type && "" != target{
            self = .AgentNative(params: params, target: target)
        } else if "web" == type {
            self = .Web
        } else if "agentweb" == type && "" != request {
            self = .AgentWeb(params: params, target: target, webView:webView, request:request)
        } else {
            self = .None
        }
    }
}

extension Dictionary {
    public func routeURI(target:String) -> (origin:String, agent:String) {
        var agent = ""
        var origin = ""
        
        agent += target
        origin += target
        
        for key in self.keys {
            if let keyName = key as? String {
                if let value = self[key] as? String {
                    if NATIVEFILLEDPARAM == value {
                        agent += "/:" + keyName
                    } else {
                        origin += "/:" + keyName
                    }
                }
            }
        }
        return (origin:origin, agent:agent)
    }
    
    public func routeURL(target:String) -> (origin:String, agent:String) {
        var agent = ""
        var origin = ""
        
        agent += target
        origin += target
        
        for key in self.keys {
            if let value = self[key] as? String {
                if NATIVEFILLEDPARAM == value {
                    agent += "/" + value
                } else {
                    origin += "/" + value
                }
            }
        }
        return (origin:origin, agent:agent)
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