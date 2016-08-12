//
//  ViewController.swift
//  MBRouter
//
//  Created by mmoaay on 07/21/2016.
//  Copyright (c) 2016 mmoaay. All rights reserved.
//

import UIKit
import MBRouter

extension ViewController:MBWebable {
    
}

class ViewController: UIViewController  {

    @IBOutlet var webContainer: MBWebContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func webPressed(sender: AnyObject) {
        self.loadRequest("https://www.baidu.com?type=web")
    }
    
    @IBAction func nativePressed(sender: AnyObject) {
        self.loadRequest("https://www.baidu.com?target=target&type=native&title=Target")
    }
    
    @IBAction func agentwebPressed(sender: AnyObject) {
        self.loadRequest("https://www.baidu.com?target=web&type=agentweb&title=_nativefilledparam&name=hehe")
    }
    
    @IBAction func agentnativePressed(sender: AnyObject) {
        self.loadRequest("https://www.baidu.com?target=agent&type=agentnative&title=_nativefilledparam&name=hehe")
    }
}

