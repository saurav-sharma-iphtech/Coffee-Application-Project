import UIKit
import CoreData

class PaymentVC: UIViewController {
    
    var indianBankNames: [[String:String]] = [
        ["name": "Dhanlaxmi Bank", "imgname": "dhan"],
        ["name": "State Bank of India", "imgname": "sbi"],
        ["name": "Punjab National Bank", "imgname": "pnb"],
        ["name": "Union Bank of India", "imgname": "unb"],
        ["name": "Indian Bank", "imgname": "ib"],
        ["name": "Dhanlaxmi Bank", "imgname": "dhan"]
    ]
    
    @IBOutlet weak var viewprice: UIView!
    var expandedIndex: Int? = nil
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var addbtn: UIButton!
    var coffeePrice: [OrdersPrice] = []
    var addressarr: [UserAddress] = []
    
    @IBOutlet weak var deliveryChargelbl: UILabel!
    @IBOutlet weak var subtotallbl: UILabel!
    @IBOutlet weak var PaymentOptionView: UITableView!
    @IBOutlet weak var addressView: UITableView!
    @IBOutlet weak var taxlbl: UILabel!
    @IBOutlet weak var totalAmountlbl: UILabel!
    
    var arrPaymentType: [[String:String]] = [
        ["name": "QR Code", "imgname": "qr2"],
        ["name": "UPI", "imgname": "upi"],
        ["name": "Net Banking", "imgname": "net2"],
        ["name": "Cash On Delivery", "imgname": "cash"],
        ["name": "Credit/Debit/ATM Card", "imgname": "card"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewprice.layer.cornerRadius = 10
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataOrdersDetails()
        setData()
        fetchDataAddressDetails()
        setuptable()
        checkisvalue()
        addressView.reloadData()
        PaymentOptionView.reloadData()
    }
    
    func checkisvalue() {
        if addressarr.isEmpty {
            editBtn?.isHidden = true
            addbtn?.isHidden = false
        } else {
            editBtn?.isHidden = false
            addbtn?.isHidden = true
        }
    }
    
    @IBAction func addBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "AddressVC") as? AddressVC {
            secondVC.isEditmode = false
            secondVC.delegate = self
            if let sheet = secondVC.sheetPresentationController {
                sheet.detents = [.large()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 20
            }
            self.present(secondVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func editBtn(_ sender: UIButton) {
        let data = addressarr.first
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "AddressVC") as? AddressVC {
            secondVC.isEditmode = true
            secondVC.exitingAddress = data
            secondVC.delegate = self
            if let sheet = secondVC.sheetPresentationController {
                sheet.detents = [.large()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 20
            }
            self.present(secondVC, animated: true, completion: nil)
        }
    }
}

extension PaymentVC: UITableViewDelegate, UITableViewDataSource {
    
    func setuptable() {
        self.PaymentOptionView.delegate = self
        self.PaymentOptionView.dataSource = self
        self.addressView.delegate = self
        self.addressView.dataSource = self
        
        self.addressView.register(UINib(nibName: "AddressCellXib", bundle: nil), forCellReuseIdentifier: "AddressCellXib")
        self.PaymentOptionView.register(UINib(nibName: "PaymentOptionCell", bundle: nil), forCellReuseIdentifier: "PaymentOptionCell")
        self.PaymentOptionView.register(UINib(nibName: "OptionsTypeCell", bundle: nil), forCellReuseIdentifier: "OptionsTypeCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1002 {
            return arrPaymentType.count + (expandedIndex != nil ? 1 : 0)
        } else {
            return addressarr.count
        }
    }
    
    func banksName(at indexPath: IndexPath) -> Bool {
        if let expandedIndex = expandedIndex {
            return indexPath.row == expandedIndex + 1
        }
        return false
    }
    
    func paymentsType(for indexPath: IndexPath) -> Int {
        if let expandedIndex = expandedIndex, indexPath.row > expandedIndex {
            return indexPath.row - 1
        }
        return indexPath.row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1002 {
            if banksName(at: indexPath) {
                let cell = PaymentOptionView.dequeueReusableCell(withIdentifier: "OptionsTypeCell", for: indexPath) as! OptionsTypeCell
                if !indianBankNames.isEmpty {
                    let name = indianBankNames[indexPath.row]
                    cell.bankname.text = name["name"]
                    let img = name["imgname"]
                    cell.logo.image = UIImage(named: img ?? "")
                }
                return cell
            } else {
                let cell = PaymentOptionView.dequeueReusableCell(withIdentifier: "PaymentOptionCell", for: indexPath) as! PaymentOptionCell
                let name = arrPaymentType[paymentsType(for: indexPath)]
                cell.paymenttypename.text = name["name"]
                let img = name["imgname"]
                cell.cardimg.image = UIImage(named: img ?? "upi")
                return cell
            }
        } else {
            guard let cell = self.addressView.dequeueReusableCell(withIdentifier: "AddressCellXib", for: indexPath) as? AddressCellXib else {
                return UITableViewCell()
            }
            
            let datas = addressarr[indexPath.row]
            cell.personnamelbl.text = "Delivering to \(datas.fullname ?? "Your Name")"
            cell.addresslbl.text = "\(datas.houseno ?? "") \(datas.landmark ?? "") \(datas.area ?? "") \(datas.city ?? "") \(datas.state ?? "") (\(datas.country ?? ""))\n \(datas.pincode ?? "")\n \(datas.mobno ?? "")"
            
            cell.deletebtn.tag = indexPath.row
            cell.deletebtn.addTarget(self, action: #selector(handleDeleteButton(_:)), for: .touchUpInside)
            
            return cell
        }
    }
    
    @objc func handleDeleteButton(_ sender: UIButton) {
        let index = sender.tag
        let deleteItems = addressarr[index]
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDelegate.persistentContainer.viewContext
        
        manageContext.delete(deleteItems)
        do {
            try manageContext.save()
            addressarr.remove(at: index)
            addressView.reloadData()
            checkisvalue()
        } catch let error as NSError {
            print("Could not delete \(error), \(error.userInfo)")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        
        if let expandedIndex = expandedIndex {
            tableView.deleteRows(at: [IndexPath(row: expandedIndex + 1, section: 0)], with: .fade)
            if expandedIndex == indexPath.row {
                self.expandedIndex = nil
            } else {
                self.expandedIndex = indexPath.row > expandedIndex ? indexPath.row - 1 : indexPath.row
                tableView.insertRows(at: [IndexPath(row: self.expandedIndex! + 1, section: 0)], with: .fade)
            }
        } else {
            expandedIndex = indexPath.row
            tableView.insertRows(at: [IndexPath(row: expandedIndex! + 1, section: 0)], with: .fade)
        }
        
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 1001 {
            return 120
        } else {
            return banksName(at: indexPath) ? 140 : 75
        }
    }
}

extension PaymentVC {
    func fetchDataOrdersDetails() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<OrdersPrice>(entityName: "OrdersPrice")
        
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let Cartdata = try managedContext.fetch(fetchRequest)
            coffeePrice = Cartdata
            PaymentOptionView.reloadData()
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    

    func fetchDataAddressDetails() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<UserAddress>(entityName: "UserAddress")
        
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let addressdata = try managedContext.fetch(fetchRequest)
            addressarr = addressdata
            addressView.reloadData()
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    func setData() {
        let datas = coffeePrice.first
        subtotallbl.text = datas?.subTotal
        deliveryChargelbl.text = datas?.deliveryCharge
        taxlbl.text = datas?.taxAmount
        totalAmountlbl.text = datas?.totalAmount
    }
}

extension PaymentVC: AddressVCDelegate {
    func didAddOrUpdateAddress() {
        fetchDataAddressDetails()
        checkisvalue()
    }
}
