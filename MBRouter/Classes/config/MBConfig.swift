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
    
    case URLFIELDFILLTYPENATIVE = "nativefilledparam"
    case URLFIELDFILLTYPEWEB = "webfilledparam"
    
    case URICALLBACKPREFIX = "callbackprefix-"
    case URITARGETPREFIX = "targetprefix-"
    case URINORMALPREFIX = "normalprefix-"
    
    case ULRFIELDTYPEWEB = "web"
    case ULRFIELDTYPENATIVE = "native"
    case ULRFIELDTYPEAGENTNATIVE = "agentnative"
    case ULRFIELDTYPEAGENTWEB = "agentweb"
}


public class MBConfig {
    public class func config() -> MBConfig{
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
    
    private var configs:[MBConfigType:String] = [:]
    
    public func set(type:MBConfigType, value:String) {
        configs[type] = value
    }
    
    public func get(type:MBConfigType) -> String {
        return configs[type]!
    }
    
    private init() {
        configs[.URLFIELDTARGET] = MBConfigType.URLFIELDTARGET.rawValue
        configs[.URLFIELDTYPE] = MBConfigType.URLFIELDTYPE.rawValue
        
        configs[.URLFIELDFILLTYPENATIVE] = MBConfigType.URLFIELDFILLTYPENATIVE.rawValue
        configs[.URLFIELDFILLTYPEWEB] = MBConfigType.URLFIELDFILLTYPEWEB.rawValue
        
        configs[.URICALLBACKPREFIX] = MBConfigType.URICALLBACKPREFIX.rawValue
        configs[.URITARGETPREFIX] = MBConfigType.URITARGETPREFIX.rawValue
        configs[.URINORMALPREFIX] = MBConfigType.URINORMALPREFIX.rawValue
        
        configs[.ULRFIELDTYPEWEB] = MBConfigType.ULRFIELDTYPEWEB.rawValue
        configs[.ULRFIELDTYPENATIVE] = MBConfigType.ULRFIELDTYPENATIVE.rawValue
        configs[.ULRFIELDTYPEAGENTNATIVE] = MBConfigType.ULRFIELDTYPEAGENTNATIVE.rawValue
        configs[.ULRFIELDTYPEAGENTWEB] = MBConfigType.ULRFIELDTYPEAGENTWEB.rawValue
    }
}

