//
//  MBTargetMapper.swift
//  Pods
//
//  Created by Perry on 16/8/11.
//
//

import Foundation

public class MBTargetMapper {
    public class func shareInstance() -> MBTargetMapper{
        struct MBSingleton{
            static var predicate:dispatch_once_t = 0
            static var instance:MBTargetMapper? = nil
        }
        dispatch_once(&MBSingleton.predicate,{
            MBSingleton.instance=MBTargetMapper()
            }
        )
        return MBSingleton.instance!
    }
    
    private var mapper:[String : AnyClass] = [:]
    
    public func add(key:String, target:String) {
        if let target = NSClassFromString(target) {
            mapper[key] = target
        }
    }
    
    public func get(key:String) -> AnyClass? {
        return mapper[key]
    }
}
