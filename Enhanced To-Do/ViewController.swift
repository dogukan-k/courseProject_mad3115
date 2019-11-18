//
//  ViewController.swift
//  Enhanced To-Do
//
//  Created by DKU on 18.11.2019.
//  Copyright © 2019 dku. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
 
    //xcdatamodeld uzantili yerde tanimladigimiz Item listi olusturuyoruz.
    var itemsList = [Items]() ;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return itemsList.count;
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath);
               let item = itemsList[indexPath.row];
               
        
               cell.textLabel?.text = item.name ;
               cell.accessoryType = item.completed ? .checkmark : .none
               //Background color of cell is up to type of item
               cell.backgroundColor = UIColor.init(named: item.strColor!);
         
               
               return cell ;
     }
     

}

    //Custom Colors
    extension UIColor {
    
    convenience init(hexString: String) {
        // Trim leading '#' if needed
        var cleanedHexString = hexString
        if hexString.hasPrefix("#") {
            
            cleanedHexString = String(hexString.dropFirst())
        }
        
        // String -> UInt32
        var rgbValue: UInt32 = 0
        Scanner(string: cleanedHexString).scanHexInt32(&rgbValue)
        
        // UInt32 -> R,G,B
        let red = CGFloat((rgbValue >> 16) & 0xff) / 255.0
        let green = CGFloat((rgbValue >> 08) & 0xff) / 255.0
        let blue = CGFloat((rgbValue >> 00) & 0xff) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}

