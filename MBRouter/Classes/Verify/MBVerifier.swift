//
//  MBVerifier.swift
//  Pods
//
//  Created by ZhengYidong on 8/23/16.
//
//

import Foundation

public class MBVerifier {
    public class func verifyURI(uri:String) -> Bool {
        return false == uri.isEmpty && true == uri.containsString("/:")
    }
    
    public class func verifyParams(params:String) -> Bool {
        return false == params.isEmpty && false != params.hasPrefix("/")
    }
    
    public class func verifyTarget(target:String) -> Bool {
        return false == target.isEmpty && true == target.hasSuffix("/:")
    }
}
