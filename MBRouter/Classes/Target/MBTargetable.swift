//
//  MBTargetable.swift
//  Pods
//
//  Created by Perry on 16/8/18.
//
//

import Foundation

protocol MBTargetable {
    static func verify() -> Bool
    static func allocWithRouterParams(routerParams:NSDictionary) -> AnyObject
}
