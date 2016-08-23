//
//  MBAgentViewController.swift
//  MBRouter
//
//  Created by Perry on 16/8/11.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import MBRouter

extension MBAgentViewController: MBTargetable {
    static func allocWithRouterParams(routerParams:NSDictionary) -> AnyObject {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewControllerWithIdentifier("MBAgentViewController")
        return controller
    }
    
    static func verify () -> Bool {
        return true
    }
}

class MBAgentViewController: UIViewController {

    @IBAction func closePressed(sender: AnyObject) {
        
        MBRouter.router().open(MBConfig.config().get(.URICALLBACKPREFIX) + "agent/:title", url: MBConfig.config().get(.URICALLBACKPREFIX) + "agent/AgentTarget")
        
        MBRouter.router().open(MBConfig.config().get(.URICALLBACKPREFIX) + "web/:title", url: MBConfig.config().get(.URICALLBACKPREFIX) + "web/AgentTarget")
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
