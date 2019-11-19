//
//  SettingsViewController.swift
//  Enhanced To-Do
//
//  Created by DKU on 19.11.2019.
//  Copyright © 2019 dku. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var shakeS: UISwitch!
    @IBOutlet weak var alertS: UISwitch!
    
    weak var viewController : ViewController?
    var incomingShakeInfo : Bool?
    var incomingAlertInfo : Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(incomingShakeInfo==true){
            shakeS.isOn = true
        }
        
        else{
            shakeS.isOn = false
        }
        
        if(incomingAlertInfo == true){
            
                   alertS.isOn = true
               }
               
               else{
                   alertS.isOn = false
               }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func shakeGestureSwitch(_ sender: UISwitch) {
        if(sender.isOn){
            viewController?.shakeGesturePermission = true
            viewController?.tableView.reloadData()
        }
        else{
            viewController?.shakeGesturePermission = false
        }
        
    }
    
    
    @IBAction func todoAlertSwitch(_ sender: UISwitch) {
        if(sender.isOn){
            viewController?.dateAlertPermission = true
        }
        
        else{
            viewController?.dateAlertPermission = false
        }
        
    }
    
    

}
