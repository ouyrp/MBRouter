//
//  MBTargetViewController.swift
//  MBRouter
//
//  Created by Perry on 16/8/11.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import Routable
import MBRouter
import React
import SnapKit

extension MBTargetViewController {
    static func allocWithRouterParams(routerParams:NSDictionary) -> AnyObject {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewControllerWithIdentifier("MBTargetViewController")
        if let title = routerParams["title"] as? String {
            controller.title = title
        }
        return controller
    }
}

class MBTargetViewController: UIViewController {
    
    var rootView:RCTRootView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initRCTView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func initRCTView() {
        let jsIndex = NSURL(string: "http://localhost:8081/index.ios.bundle?platform=ios&dev=true")
        
        rootView = RCTRootView(bundleURL:jsIndex, moduleName:"SampleAppMovies", initialProperties:nil, launchOptions:nil)
        
        view.addSubview(rootView!)
        
        rootView!.snp_makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(view)
        }
    }
    
    deinit {
        rootView = nil
    }
    
}
