//
//  MBConfig.swift
//  Pods
//
//  Created by Perry on 16/8/15.
//
//

import Foundation

public enum MBConfigType: String {
    case URLFIELDTARGET = "target"
    case URLFIELDTYPE = "type"
    
    case URLFIELDNATIVEFILLEDPARAM = "nativefilledparam"
    case URIAGENTCALLBACKPREFIX = "agentcallback"
    case URIAGENTTARGETPREFIX = "agenttarget"
    
    case ULRFIELDTYPEWEB = "web"
    case ULRFIELDTYPENATIVE = "native"
    case ULRFIELDTYPEAGENTNATIVE = "agentnative"
    case ULRFIELDTYPEAGENTWEB = "agentweb"
}


public class MBConfig {
    public class func shareInstance() -> MBConfig{
        struct MBSingleton{
            static var predicate:dispatch_once_t = 0
            static var instance:MBConfig? = nil
        }
        dispatch_once(&MBSingleton.predicate,{
            MBSingleton.instance = MBConfig()
            }
        )
        return MBSingleton.instance!
    }
    
    private var config:[MBConfigType : String] = [:]
    
    func set(type:MBConfigType, value:String) {
        config[type] = value
    }
    
    func get (type:MBConfigType) -> String {
        return config[type]!
    }
    
    init() {
        config[.URLFIELDTARGET] = MBConfigType.URLFIELDTARGET.rawValue
        config[.URLFIELDTYPE] = MBConfigType.URLFIELDTYPE.rawValue
        config[.URLFIELDNATIVEFILLEDPARAM] = MBConfigType.URLFIELDNATIVEFILLEDPARAM.rawValue
        config[.URIAGENTCALLBACKPREFIX] = MBConfigType.URIAGENTCALLBACKPREFIX.rawValue
        config[.URIAGENTTARGETPREFIX] = MBConfigType.URIAGENTTARGETPREFIX.rawValue
        
        config[.ULRFIELDTYPEWEB] = MBConfigType.ULRFIELDTYPEWEB.rawValue
        config[.ULRFIELDTYPENATIVE] = MBConfigType.ULRFIELDTYPENATIVE.rawValue
        config[.ULRFIELDTYPEAGENTNATIVE] = MBConfigType.ULRFIELDTYPEAGENTNATIVE.rawValue
        config[.ULRFIELDTYPEAGENTWEB] = MBConfigType.ULRFIELDTYPEAGENTWEB.rawValue
    }
}

