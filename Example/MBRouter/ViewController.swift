//
//  ViewController.swift
//  MBRouter
//
//  Created by mmoaay on 07/21/2016.
//  Copyright (c) 2016 mmoaay. All rights reserved.
//

import UIKit
import MBRouter

extension UIViewController:MBWebable {
    
}

class ViewController: UIViewController  {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loadRequest("https://www.baidu.com?target=ViewController")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

