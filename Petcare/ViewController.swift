//
//  ViewController.swift
//  Petcare
//
//  Created by Felipe Borges on 25/11/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WatchConnectivityManagerPhoneDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Ha! I don't do anything but i'm still cool
        
        WatchConnectivityManager.sharedConnectivityManager.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func watchConnectivityManager(_ watchConnectivityManager: WatchConnectivityManager, updatedWithDesignator designator: String, designatorColor: String) {
        DispatchQueue.main.async(execute: {
        })
    }



}

