//
//  MBParser.swift
//  Pods
//
//  Created by Perry on 16/8/9.
//
//

import Foundation

enum MBTargetType {
    case Web,Native
}

extension String:MBParseable {
    
}

public protocol MBParseable {
    var url:String { get }
    
    var parameters:Dictionary<String, String> { get }
}
