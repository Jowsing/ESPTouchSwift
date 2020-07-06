//
//  ViewController.swift
//  ESPTouchSwift
//
//  Created by WooKeyWallet on 06/21/2020.
//  Copyright (c) 2020 WooKeyWallet. All rights reserved.
//

import UIKit
import ESPTouchSwift

class ViewController: UIViewController {
    
    let manager = ESPTouchManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager.timeout = 60
        manager.smartConfig(password: "your wifi password") { (result) in
            switch result {
            case .success(let model):
                print(model.bssid)
            case .failure(let error):
                switch error {
                case .noSsid:
                    print("noSsid")
                case .timeout:
                    print("timeout")
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

