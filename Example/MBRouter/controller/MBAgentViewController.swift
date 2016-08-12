//
//  MBAgentViewController.swift
//  MBRouter
//
//  Created by Perry on 16/8/11.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import Routable

extension MBAgentViewController {
    static func allocWithRouterParams(routerParams:NSDictionary) -> AnyObject {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewControllerWithIdentifier("MBAgentViewController")
        return controller
    }
}

class MBAgentViewController: UIViewController {

    @IBAction func closePressed(sender: AnyObject) {
        Routable.sharedRouter().open("agentcallbackagent/AgentTarget")
//        Routable.sharedRouter().open("agentcallbackweb/AgentTarget")
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
