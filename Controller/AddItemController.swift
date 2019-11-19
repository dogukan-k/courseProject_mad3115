//
//  AddItemController.swift
//  Enhanced To-Do
//
//  Created by DKU on 18.11.2019.
//  Copyright © 2019 dku. All rights reserved.
//

import UIKit

class AddItemController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var btnLow: UIButton!
    @IBOutlet weak var btnMid: UIButton!
    @IBOutlet weak var btnHigh: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
      var itemPriority:Double = 1;
      var color = "00F900";
    

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext ;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddItemController.viewTapped(gestureRecognnizer:))) ;
        view.addGestureRecognizer(tapGesture);
        
        self.txtField.delegate = self;

        // Do any additional setup after loading the view.
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
        
        let alertSuccesful = UIAlertController(title: "New To-Do Item Saved", message: "", preferredStyle: .alert);
        alertSuccesful.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.darkGray
        alertSuccesful.view.tintColor = UIColor.white
                 
        let ok = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
            alertSuccesful.dismiss(animated: true) {
    
            //Go back to main page
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil);
                     }
                 }
                     
       
        
        if(txtField.text != ""){
                 
                 let newItem = Items(context: self.context);
                 newItem.name = txtField.text;
                 newItem.completed = false ;
                 newItem.priority = itemPriority ;
                 newItem.itemDate = datePicker.date;
                 newItem.strColor = color;
                 
                 
               
                 self.saveItems();
            
                 alertSuccesful.addAction(ok);
                 present(alertSuccesful, animated: true, completion: nil);
          
                 
             }
        
        else{
                  //Alert fill item name
                  let alert = UIAlertController(title: "Please Enter To-Do", message: "", preferredStyle: .alert);
                  alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.darkGray
                  alert.view.tintColor = UIColor.white
                             
                             let okAction = UIAlertAction(title: "Ok", style: .default) { (okAction) in
                                 alert.dismiss(animated: true, completion: nil) ;
                                 
                                
                             }
                             
                             alert.addAction(okAction);
                             present(alert, animated: true, completion: nil);
              }
        
        
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
    
    //When tapped rather than keyboard , keyboard will closed
    @objc func viewTapped(gestureRecognnizer : UITapGestureRecognizer){

           view.endEditing(true);
       }
    
    //return button will close the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

 

}

//extension UIView{
//    func blink() {
//        self.alpha = 0.2
//        UIView.animate(withDuration: 1, delay: 0.5, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
//    }
//}
//
//extension UIView{
//    func stopBlink() {
//        self.alpha = 1
//        self.layer.removeAllAnimations()
//    }
//}

