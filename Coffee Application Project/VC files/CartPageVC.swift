//
//  HomaAppVC.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 01/05/25.
//

import UIKit
import CoreData

class CartPageVC: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var totalamountlbl: UILabel!
    var coffeeMenu :[CartDetails] = []
    @IBOutlet weak var promoview: UIView!
    @IBOutlet weak var amountview: UIView!
    @IBOutlet weak var deliveryfeelbl: UILabel!
    
    @IBOutlet weak var taxlbl: UILabel!
    @IBOutlet weak var subtotallbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    //    self.navigationController?.setNavigationBarHidden(true, animated: false)
        subtotallbl.text = "$0"
        taxlbl.text = "$0"
        deliveryfeelbl.text = "$0"
        totalamountlbl.text = "$0"
//        setupCorner()
//        fetchData()
//        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        updateSummary()
        setupTable()
    }
    
    @IBAction func checkoutbtn(_ sender: UIButton) {
        addorserprice()
        pageChange()
    }
}

extension CartPageVC{
    
    func pageChange(){
        print("add button tapped")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "PaymentVC") as? PaymentVC {
         
            navigationController?.pushViewController(vc, animated: true)
            print("page changed")
        }
    }
    
    func setupTable(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register( UINib(nibName: "CartViewCell", bundle: nil), forCellReuseIdentifier: "CartViewCell")
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeMenu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"CartViewCell", for: indexPath) as? CartViewCell else{return UITableViewCell()}
        
        
        let arr = coffeeMenu[indexPath.row]
        cell.nameLbl.text = arr.coffeeName
        cell.pricelbl.text = arr.amount
        cell.cupSize.text = "Size: \(arr.cupSize ?? "S")"
        cell.cupcount.text = arr.itemCount
        
        updateSummary()
        cell.deleteBtn.tag = indexPath.row
        cell.plusbtn.tag = indexPath.row
        cell.minusBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(handleDeleteButton(_:)), for: .touchUpInside)
        cell.plusbtn.addTarget(self, action: #selector(handlePlusButton(_:)), for: .touchUpInside)
        cell.minusBtn.addTarget(self, action: #selector(handleMinusButton(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func handlePlusButton(_ sender: UIButton) {
        let row = sender.tag
        
     
        let indexPath = IndexPath(row: row, section: 0)
        
        
        if let count = Int(coffeeMenu[row].itemCount!) {
            let newCount = count + 1
            print(newCount)
            
    
            if let realPrice = coffeeMenu[row].realPrice, let newPrice = Double(realPrice) {
                let updatedPrice = newPrice * Double(newCount)
                coffeeMenu[row].amount = String(updatedPrice)
                

                coffeeMenu[row].itemCount = "\(newCount)"
                
            
                if let cell = tableView.cellForRow(at: indexPath) as? CartViewCell {
                    
                    cell.pricelbl.text = "$\(String(format: "%.2f", updatedPrice))"
                }
                
                
                tableView.reloadRows(at: [indexPath], with: .none)
                updateSummary()
            }
        }
    }
    
    
    @objc func handleMinusButton(_ sender: UIButton) {
        let row = sender.tag
        

        if let count = Int(coffeeMenu[row].itemCount!), count > 1 {
            let newCount = count - 1
            coffeeMenu[row].itemCount = "\(newCount)"
            

            if let realPrice = coffeeMenu[row].realPrice, let newPrice = Double(realPrice) {
                let updatedPrice = newPrice * Double(newCount)
                coffeeMenu[row].amount = String(updatedPrice)
                
             
                let indexPath = IndexPath(row: row, section: 0)
                
               
                if let cell = tableView.cellForRow(at: indexPath) as? CartViewCell {
               
                    cell.pricelbl.text = "$\(String(format: "%.2f", updatedPrice))"
                }
                
                tableView.reloadRows(at: [indexPath], with: .none)
                updateSummary()
            }
        }
    }
    
    
    
    @objc func handleDeleteButton(_ sendar:UIButton){
        let index = sendar.tag
        
        let deleteItems = coffeeMenu[index]
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let manageContext = appDelegate.persistentContainer.viewContext
        manageContext.delete(deleteItems)
        do{
            try manageContext.save()
            coffeeMenu.remove(at: index)
            updateSummary()
            tableView.reloadData()
          
            print("item Deleted")
        }catch let error as NSError {
            print("Could not delete \(error), \(error.userInfo)")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}


extension CartPageVC{
    
    func setupCorner(){
        promoview.layer.cornerRadius = 30
        amountview.layer.cornerRadius = 10
    }
    
    func fetchData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<CartDetails>(entityName: "CartDetails")
        
        fetchRequest.returnsObjectsAsFaults = false
        do{
            let Cartdata = try managedContext.fetch(fetchRequest)
            
            coffeeMenu = Cartdata
            tableView.reloadData()
            debugPrint(Cartdata)
        }catch let error as NSError {
            debugPrint(error)
        }
        
        
    }
}

extension CartPageVC{
    func updateSummary() {
        var subtotal: Double = 0.0
        let deliveryFee: Double = 5.0
        let taxRate: Double = 0.18
        
        for item in coffeeMenu {
            if let amount = Double(item.amount ?? "") {
                subtotal += amount
            }
        }
        let tax = subtotal * taxRate
        let totalAmount = subtotal + tax + deliveryFee
        
        subtotallbl.text = "$\(String(format: "%.2f", subtotal))"
        taxlbl.text = "$\(String(format: "%.2f", tax))"
        deliveryfeelbl.text = "$\(String(format: "%.2f", deliveryFee))"
        totalamountlbl.text = "$\(String(format: "%.2f", totalAmount))"
    }
}

extension CartPageVC{
    
    func addorserprice() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<OrdersPrice> = OrdersPrice.fetchRequest()

        do {
            let existingOrders = try context.fetch(fetchRequest)

            // If exists, update the first one
            let order: OrdersPrice
            if let firstOrder = existingOrders.first {
                order = firstOrder
            } else {
                // If not exists, create a new one
                order = OrdersPrice(context: context)
            }

            // Set or update values
            order.deliveryCharge = deliveryfeelbl.text
            order.subTotal = subtotallbl.text
            order.taxAmount = taxlbl.text
            order.totalAmount = totalamountlbl.text

            try context.save()
            print("Order data saved or updated.")

        } catch let error as NSError {
            print("Could not fetch or save order data: \(error), \(error.userInfo)")
        }
    }

    
    
}
