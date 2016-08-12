//
//  MBAgentNavViewController.swift
//  MBRouter
//
//  Created by Perry on 16/8/11.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

extension MBAgentNavViewController {
    static func allocWithRouterParams(routerParams:NSDictionary) -> AnyObject {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewControllerWithIdentifier("MBAgentNavViewController")
        return controller
    }
}

class MBAgentNavViewController: UINavigationController {

}
