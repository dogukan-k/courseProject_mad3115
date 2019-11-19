//
//  EditItemViewController.swift
//  Enhanced To-Do
//
//  Created by DKU on 18.11.2019.
//  Copyright © 2019 dku. All rights reserved.
//

import UIKit

class EditItemViewController: UIViewController {

    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var btnLow: UIButton!
    @IBOutlet weak var btnMid: UIButton!
    @IBOutlet weak var btnHigh: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLowPriority(_ sender: UIButton) {
    
    }
    
    @IBAction func btnMidPriority(_ sender: UIButton) {
        
    }
    
    @IBAction func btnHighPriority(_ sender: UIButton) {
        
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        
        
    }

}

extension UIView{
    func blink() {
        self.alpha = 0.2
        UIView.animate(withDuration: 1, delay: 0.5, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
    }
}

extension UIView{
    func stopBlink() {
        self.alpha = 1
        self.layer.removeAllAnimations()
    }
}

