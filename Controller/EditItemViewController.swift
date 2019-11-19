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
    
    //Will be deterdmined according to incoming item
    var itemPriority:Double = 0;
    var color = "";
    
     var incomingItem : Items? = nil
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext ;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(incomingItem!.strColor == "00F900"){
             btnLow.blink();
        }
        
        else if(incomingItem?.strColor == "7A81FF"){
             btnMid.blink();
        }
        // Do any additional setup after loading the view.
        
        else{
             btnHigh.blink();
        }
        
        txtField.text = incomingItem!.name;
        datePicker.date = incomingItem!.itemDate!;
    }
    
       @IBAction func btnLowPriority(_ sender: UIButton) {
        
               btnHigh.stopBlink();
               btnMid.stopBlink();
               btnLow.blink();
               
               itemPriority = 1 ;
               color = "00F900"
    }
    
    @IBAction func btnMidPriority(_ sender: UIButton) {
        
             btnHigh.stopBlink();
             btnLow.stopBlink();
             btnMid.blink();
             
             itemPriority = 2 ;
             color = "7A81FF"
        
    }
    
    @IBAction func btnHighPriority(_ sender: UIButton) {
        
              btnLow.stopBlink();
              btnMid.stopBlink()
              btnHigh.blink();
              
              itemPriority = 3 ;
              color = "FF9300"
        
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        
        incomingItem!.name = txtField.text
        incomingItem!.itemDate = datePicker.date;
        incomingItem!.strColor = color ;
        incomingItem!.priority = itemPriority ;
        self.saveItems();
        
    }
    
    func saveItems(){
         
         do {
             try context.save();
         }
         catch
         {
             print("\(error)")
         }
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

