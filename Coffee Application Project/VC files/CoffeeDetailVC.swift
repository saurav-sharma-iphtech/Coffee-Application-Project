//
//  CoffeeDetailVC.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 15/05/25.
//

import UIKit

class CoffeeDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var value: UILabel!
    
    @IBOutlet weak var scupsizelbl: UILabel!
    
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var cupimg: UIImageView!
    var coffeeData :[String : String] = [:]
    @IBOutlet weak var uview: UIView!
    let arrCupSize = ["S","M","L"]
    var realprice : String = ""
    var a: UInt = 1
    var price: Double = 0
    var fvalue : Double = 0
    var selectedItems :String = ""
    @IBOutlet weak var cupSizeView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        setProperty()
        setupview()
       
        
    }
    
    func setProperty(){
       
        uview.layer.cornerRadius = 10
        cupimg.layer.cornerRadius = 10
        lblname.text = coffeeData["name"]
//        realprice = "$" + (coffeeData["price"] ?? "")
        realprice = (coffeeData["price"] ?? "")
        print(realprice)
//        lblprice.text = "$" + (coffeeData["price"] ?? "")
        lblprice.text = coffeeData["price"] ?? ""
        let imgName = coffeeData["image"] ?? ""
        cupimg.image = imgName.isEmpty ? UIImage(named:"profile_avatar") :  UIImage(named: imgName)
        price = Double(coffeeData["price"] ?? "") ?? 0.0
        fvalue = price
        
    }
    
    @IBAction func addcartbtn(_ sender: UIButton) {
        addEmployee()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func plusbtn(_ sender: UIButton) {
        a = a + 1
        value.text = String(a)
        
        price += fvalue
        lblprice.text =  String(price)
//        lblprice.text = "$" + String(price)
        
    }
    
    @IBAction func minusbtn(_ sender: UIButton) {
        a = a - 1
        if a<1{
            self.dismiss(animated: true, completion: nil)
        }
        else{
           
            value.text = String(a)
            
            
            price -= fvalue
//            lblprice.text = "$" + String(price)
            lblprice.text =  String(price)
        }
    }
}

extension CoffeeDetailVC{
    
    func setupview(){
        self.cupSizeView.delegate = self
        self.cupSizeView.dataSource = self
        self.cupSizeView.register(UINib(nibName: "ButtonViewCell", bundle: nil), forCellWithReuseIdentifier: "ButtonViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCupSize.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = self.cupSizeView.dequeueReusableCell(withReuseIdentifier: "ButtonViewCell", for: indexPath) as? ButtonViewCell else{
            return UICollectionViewCell()
        }
        
        let ss = arrCupSize[indexPath.row]
        //        cell.btnc.setTitle(ss, for: .normal)
        cell.btnlbl.text = ss
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let contentSizeWidth =  collectionView.bounds.size.width
        let cellWidth =  contentSizeWidth * 0.5 - 10
        return  CGSize(width:cellWidth , height:cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedItems = arrCupSize[indexPath.row]
        print(selectedItems)
        
        
        
    }
}

extension CoffeeDetailVC{
    
    func addEmployee(){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let appDelegate = appDelegate else{
            return
        }
        let manageContext = appDelegate.persistentContainer.viewContext
        let cartData = CartDetails(context: manageContext)
    
        cartData.amount = lblprice.text
        cartData.coffeeName = lblname.text
        cartData.cupSize = selectedItems
        cartData.itemCount = value.text
        cartData.realPrice = realprice
        print(realprice)
        
        do{
            try manageContext.save()
            debugPrint("data Save")
        }catch let error as NSError {
            debugPrint(error)
        }
    }
    
    
}



