//
//  MBRouter.swift
//  Pods
//
//  Created by Perry on 16/8/10.
//
//

import Foundation
import Routable

public class MBRouter {
    public static func loadRoutes(file:String) {
        
    }
    
    public static func addRoute(routeURI:String, targetClassName:String) {
        if let target = NSClassFromString(targetClassName) {
            Routable.sharedRouter().map(routeURI, toController:target)
        }
    }
}
