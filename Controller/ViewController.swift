//
//  ViewController.swift
//  Enhanced To-Do
//
//  Created by DKU on 18.11.2019.
//  Copyright © 2019 dku. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
  
    //xcdatamodeld items will be stored at that
    var itemsList = [Items]() ;
    
    //Context will used as container that keeps persistence data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var tableView: UITableView!
    var pushedIndex = 0 ;
    var itemListCountBeforeDeleting = 0 ;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
      
       
    }
    
    //Order the itemlist according to their priority
    override func viewWillAppear(_ animated: Bool) {
        loadItems() ;
        itemsList.sort { $0.priority > $1.priority }
        tableView.reloadData();
    }
    
    //Convert the boolean value to opposite  and save
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         tableView.deselectRow(at: indexPath, animated: true);
               
               itemsList[indexPath.row].completed = !itemsList[indexPath.row].completed
               
               saveItems();
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return true;
       }
    
    //Delete action of rows
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if(editingStyle == .delete){
            let item = itemsList[indexPath.row];
            
            itemListCountBeforeDeleting = itemsList.count;
            
            itemsList.remove(at: indexPath.row);
            context.delete(item);
            
            
            do{
                
                try context.save();
            }
            catch{
                print("\(error) ")
            }
        
            tableView.deleteRows(at: [indexPath], with: .automatic);
            
        }
        
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return itemsList.count;
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath);
               let item = itemsList[indexPath.row];
               
               cell.textLabel!.font = UIFont(name:"Bradley Hand", size:22)
               cell.textLabel!.textColor = .white ;
               cell.textLabel!.textAlignment = .center
               cell.textLabel?.text = item.name ;
               cell.accessoryType = item.completed ? .checkmark : .none
               cell.accessoryView?.tintColor = .white
               cell.layer.cornerRadius = 25 ;
               cell.layer.masksToBounds = true
              
               cell.layer.borderColor = UIColor.darkGray.cgColor
               cell.layer.borderWidth = 10
        
               //Background color of cell is up to type of item
               cell.backgroundColor = UIColor.init(hexString: item.strColor!);
        
            
               
               return cell ;
     }
    
    
    //When swipe cell , roundstyle gone so , swipped cell should be reloaded at the end of editing if not deleted
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        if(itemListCountBeforeDeleting == itemsList.count){
            
              tableView.reloadRows(at: [indexPath!], with: .none)
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
        tableView.reloadData();
    }
    
    func loadItems(){
        
        let request : NSFetchRequest<Items> = Items.fetchRequest();
        
        
        do{
        itemsList = try context.fetch(request)
        }
        catch{
            print("\(error)")
        }

        tableView.reloadData();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if(segue.identifier == "addItem"){
            
        }
        
        if(segue.identifier == "editItem"){
            let vc = segue.destination as! EditItemViewController;
            
            vc.incomingItem = itemsList[pushedIndex]
        }
        
        
    }
    @IBAction func addNewItemButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addItem", sender: nil);
    }
    
    //Edit item
        func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
            pushedIndex = indexPath.row;
    
        let closeAction = UIContextualAction(style: .destructive, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            self.performSegue(withIdentifier: "editItem", sender: nil);
           
            success(true)
        
          
        })
            
              
        closeAction.backgroundColor = .brown
           
       
        return UISwipeActionsConfiguration(actions: [closeAction])

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
        
        // String -> UInt64
        var rgbValue: UInt64 = 0
        Scanner(string: cleanedHexString).scanHexInt64(&rgbValue)
        
        // UInt32 -> R,G,B
        let red = CGFloat((rgbValue >> 16) & 0xff) / 255.0
        let green = CGFloat((rgbValue >> 08) & 0xff) / 255.0
        let blue = CGFloat((rgbValue >> 00) & 0xff) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}



