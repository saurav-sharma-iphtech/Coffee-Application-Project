import UIKit
import CoreData

class PaymentVC: UIViewController {
    
    enum PaymentOptionSubviewType {
        case upi, card, bankOptions, qr, cod
    }
    
    var indianBankNames: [[String:String]] = [
        ["name": "Dhanlaxmi Bank", "imgname": "dhan"],
        ["name": "State Bank of India", "imgname": "sbi"],
        ["name": "Panjab National Bank", "imgname": "pnb"],
        ["name": "Indian Bank", "imgname": "ib"],
        ["name": "Union Bank of India", "imgname": "unb"]
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
        ["name": "UPI", "imgname": "upi"],
        ["name": "Credit/Debit/ATM Card", "imgname": "card"],
        ["name": "Net Banking", "imgname": "net2"],
        ["name": "QR Code", "imgname": "qr2"],
        ["name": "Cash On Delivery", "imgname": "cash"]
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
    
    func getSubviewType(for index: Int) -> PaymentOptionSubviewType? {
        switch index {
        case 0: return .upi
        case 1: return .card
        case 2: return .bankOptions
        case 3: return .qr
        case 4: return .cod
        default: return nil
        }
    }
    
    func checkisvalue() {
        editBtn?.isHidden = addressarr.isEmpty
        addbtn?.isHidden = !addressarr.isEmpty
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
            present(secondVC, animated: true)
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
            present(secondVC, animated: true)
        }
    }
}

extension PaymentVC: UITableViewDelegate, UITableViewDataSource {
    
    func setuptable() {
        PaymentOptionView.delegate = self
        PaymentOptionView.dataSource = self
        addressView.delegate = self
        addressView.dataSource = self
        
        addressView.register(UINib(nibName: "AddressCellXib", bundle: nil), forCellReuseIdentifier: "AddressCellXib")
        PaymentOptionView.register(UINib(nibName: "PaymentOptionCell", bundle: nil), forCellReuseIdentifier: "PaymentOptionCell")
        PaymentOptionView.register(UINib(nibName: "OptionsTypeCell", bundle: nil), forCellReuseIdentifier: "OptionsTypeCell")
        PaymentOptionView.register(UINib(nibName: "UpiXibss", bundle: nil), forCellReuseIdentifier: "UpiXibss")
        PaymentOptionView.register(UINib(nibName: "cardxibs", bundle: nil), forCellReuseIdentifier: "cardxibs")
        PaymentOptionView.register(UINib(nibName: "QrandCashOnDeliveryXibs", bundle: nil), forCellReuseIdentifier: "QrandCashOnDeliveryXibs")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == PaymentOptionView {
            if let expanded = expandedIndex {
                if getSubviewType(for: expanded) == .bankOptions {
                    // For bank options, add expanded rows for each bank
                    return arrPaymentType.count + indianBankNames.count
                } else {
                    // For other types, add only 1 expanded row
                    return arrPaymentType.count + 1
                }
            } else {
                return arrPaymentType.count
            }
        } else {
            return addressarr.count
        }
    }
    
    func banksName(at indexPath: IndexPath) -> Bool {
        guard let expanded = expandedIndex else { return false }
        
        if getSubviewType(for: expanded) == .bankOptions {
            // expanded + 1 ... expanded + number of banks are bank rows
            let range = (expanded+1)...(expanded + indianBankNames.count)
            return range.contains(indexPath.row)
        } else {
            return indexPath.row == expanded + 1
        }
    }
    
    func paymentsType(for indexPath: IndexPath) -> Int {
        guard let expanded = expandedIndex else { return indexPath.row }
        
        if getSubviewType(for: expanded) == .bankOptions {
            if indexPath.row <= expanded {
                return indexPath.row
            } else if indexPath.row > expanded + indianBankNames.count {
                return indexPath.row - indianBankNames.count
            } else {
                // These are bank option rows - no payment type
                return -1
            }
        } else {
            // If expanded, rows after expanded are shifted by 1
            return indexPath.row > expanded ? indexPath.row - 1 : indexPath.row
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == PaymentOptionView {
            
            if banksName(at: indexPath) {
                guard let expanded = expandedIndex,
                      let subviewType = getSubviewType(for: expanded) else {
                    return UITableViewCell()
                }
                
                switch subviewType {
                case .upi:
                    return tableView.dequeueReusableCell(withIdentifier: "UpiXibss", for: indexPath)
                case .card:
                    return tableView.dequeueReusableCell(withIdentifier: "cardxibs", for: indexPath)
                case .bankOptions:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsTypeCell", for: indexPath) as! OptionsTypeCell
                    
                    // indexPath.row - expanded - 1 gives bank index
                    let bankIndex = indexPath.row - expanded - 1
                    if bankIndex < indianBankNames.count {
                        let bank = indianBankNames[bankIndex]
                        cell.bankname.text = bank["name"]
                        cell.logo.image = UIImage(named: bank["imgname"] ?? "")
                    }
                    return cell
                case .cod:
                    return tableView.dequeueReusableCell(withIdentifier: "QrandCashOnDeliveryXibs", for: indexPath)
                case .qr:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "QrandCashOnDeliveryXibs", for: indexPath) as? QrandCashOnDeliveryXibs
                    cell?.titlelbl.text = "Pay By QR Code"
                    return cell!
                }
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentOptionCell", for: indexPath) as! PaymentOptionCell
                let paymentIndex = paymentsType(for: indexPath)
                if paymentIndex >= 0 && paymentIndex < arrPaymentType.count {
                    let data = arrPaymentType[paymentIndex]
                    cell.paymenttypename.text = data["name"]
                    cell.cardimg.image = UIImage(named: data["imgname"] ?? "")
                }
                return cell
            }
        } else {
            let cell = addressView.dequeueReusableCell(withIdentifier: "AddressCellXib", for: indexPath) as! AddressCellXib
            let data = addressarr[indexPath.row]
            cell.personnamelbl.text = "Delivering to \(data.fullname ?? "Your Name")"
            cell.addresslbl.text = "\(data.houseno ?? "") \(data.landmark ?? "") \(data.area ?? "") \(data.city ?? "") \(data.state ?? "") (\(data.country ?? ""))\n \(data.pincode ?? "")\n \(data.mobno ?? "")"
            cell.deletebtn.tag = indexPath.row
            cell.deletebtn.addTarget(self, action: #selector(handleDeleteButton(_:)), for: .touchUpInside)
            return cell
        }
    }
    
    @objc func handleDeleteButton(_ sender: UIButton) {
        let index = sender.tag
        let deleteItem = addressarr[index]
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        context.delete(deleteItem)
        do {
            try context.save()
            addressarr.remove(at: index)
            addressView.reloadData()
            checkisvalue()
        } catch {
            print("Delete failed: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView == PaymentOptionView else { return }
        
        tableView.beginUpdates()
        
        if let expanded = expandedIndex {
            // Remove old expanded rows
            if getSubviewType(for: expanded) == .bankOptions {
                // Delete all expanded bank rows
                var deleteIndexPaths: [IndexPath] = []
                for i in 1...indianBankNames.count {
                    deleteIndexPaths.append(IndexPath(row: expanded + i, section: 0))
                }
                tableView.deleteRows(at: deleteIndexPaths, with: .fade)
            } else {
                // Delete single expanded row
                tableView.deleteRows(at: [IndexPath(row: expanded + 1, section: 0)], with: .fade)
            }
            
            if expanded == indexPath.row {
                // Collapse if tapped same row
                expandedIndex = nil
            } else {
                // Calculate new expanded index adjusting for previous expansion size
                
                var newExpandedIndex = indexPath.row
                if getSubviewType(for: expanded) == .bankOptions && indexPath.row > expanded {
                    newExpandedIndex -= indianBankNames.count
                } else if indexPath.row > expanded {
                    newExpandedIndex -= 1
                }
                
                expandedIndex = newExpandedIndex
                
                // Insert new expanded rows
                if getSubviewType(for: expandedIndex!) == .bankOptions {
                    var insertIndexPaths: [IndexPath] = []
                    for i in 1...indianBankNames.count {
                        insertIndexPaths.append(IndexPath(row: expandedIndex! + i, section: 0))
                    }
                    tableView.insertRows(at: insertIndexPaths, with: .fade)
                } else {
                    tableView.insertRows(at: [IndexPath(row: expandedIndex! + 1, section: 0)], with: .fade)
                }
            }
        } else {
            // No expanded row - expand new
            expandedIndex = indexPath.row
            
            if getSubviewType(for: expandedIndex!) == .bankOptions {
                var insertIndexPaths: [IndexPath] = []
                for i in 1...indianBankNames.count {
                    insertIndexPaths.append(IndexPath(row: expandedIndex! + i, section: 0))
                }
                tableView.insertRows(at: insertIndexPaths, with: .fade)
            } else {
                tableView.insertRows(at: [IndexPath(row: expandedIndex! + 1, section: 0)], with: .fade)
            }
        }
        
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == PaymentOptionView {
            if banksName(at: indexPath) {
                guard let expanded = expandedIndex,
                      let subviewType = getSubviewType(for: expanded) else {
                    return 140
                }
                switch subviewType {
                case .upi: return 210
                case .card: return 250
                case .bankOptions: return 140
                case .qr, .cod: return 140
                }
            }
            return 75
        }
        return 150
    }
}

extension PaymentVC {
    func fetchDataOrdersDetails() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<OrdersPrice>(entityName: "OrdersPrice")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            coffeePrice = try context.fetch(fetchRequest)
        } catch {
            print("Fetch failed: \(error)")
        }
    }
    
    func fetchDataAddressDetails() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<UserAddress>(entityName: "UserAddress")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            addressarr = try context.fetch(fetchRequest)
        } catch {
            print("Fetch failed: \(error)")
        }
    }
    
    func setData() {
        guard let data = coffeePrice.first else { return }
        subtotallbl.text = data.subTotal
        deliveryChargelbl.text = data.deliveryCharge
        taxlbl.text = data.taxAmount
        totalAmountlbl.text = data.totalAmount
    }
}

extension PaymentVC: AddressVCDelegate {
    func didAddOrUpdateAddress() {
        fetchDataAddressDetails()
        checkisvalue()
        addressView.reloadData()
    }
}
