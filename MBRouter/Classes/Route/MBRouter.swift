//
//  MBRouter.swift
//  Pods
//
//  Created by Perry on 16/8/11.
//
//

import Foundation
import Routable

public class MBRouter {
    public class func router() -> MBRouter{
        struct MBSingleton{
            static var predicate:dispatch_once_t = 0
            static var instance:MBRouter? = nil
        }
        dispatch_once(&MBSingleton.predicate,{
            MBSingleton.instance = MBRouter()
            }
        )
        return MBSingleton.instance!
    }
    
    private var mapper:[String:Bool] = [:]
    
    public func setNav(nav:UINavigationController) {
        Routable.sharedRouter().navigationController = nav
    }
    
    public func map(uri:String, target:String) {
        guard true == MBVerifier.verifyURI(uri) else {
            print("参数有误！ uri:" + uri)
            return
        }
        
        if let target = NSClassFromString(target) {
            mapper[MBConfig.config().get(.URINORMALPREFIX) + uri] = true
            Routable.sharedRouter().map(uri, toController: target)
        }
    }
    
    public func setEnabled(uri:String, enabled:Bool) {
        mapper[uri] = enabled
    }
    
    public func map(uri:String, params:(web:String, native:String), agent:String, target:String = "") {
        guard true == MBVerifier.verifyTarget(uri)
            && true == MBVerifier.verifyParams(params.web)
            && true == MBVerifier.verifyParams(params.native) else {
            print("参数有误！ uri:" + uri + " web:" + params.web + " native" + params.native)
            return
        }
        if let agent =  NSClassFromString(agent) {
            
            mapper[uri + params.native] = true
            mapper[MBConfig.config().get(.URICALLBACKPREFIX) + uri + params.native ] = false
            
            Routable.sharedRouter().map(MBConfig.config().get(.URINORMALPREFIX) + uri + params.native, toController: agent, withOptions: UPRouterOptions.modal().withPresentationStyle(.FullScreen))
        }
        
        if let target = NSClassFromString(target) {
            mapper[MBConfig.config().get(.URITARGETPREFIX) + uri + params.web + params.native] = true
            
            Routable.sharedRouter().map(MBConfig.config().get(.URITARGETPREFIX) + uri + params.web + params.native, toController: target)
        }
    }
    
    public func open(uri:String, url:String) {
        if let enabled = mapper[uri] {
            if true == enabled && isEqual(uri, url: url) {
                Routable.sharedRouter().open(url)
            }
        }
    }
    
    private func isEqual(uri:String, url:String) -> Bool {
        let uris = uri.componentsSeparatedByString("/")
        let urls = url.componentsSeparatedByString("/")
        if uris.count > 0 && urls.count > 0 {
            if uris[0] == urls[0] && uris.count == urls.count {
                return true
            }
        }
        return false
    }
}
