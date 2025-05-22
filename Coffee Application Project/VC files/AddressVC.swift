//
//  AddressVC.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 21/05/25.
//

import UIKit
import CoreData

protocol AddressVCDelegate: AnyObject {
    func didAddOrUpdateAddress()
}

class AddressVC: UIViewController {
    
    @IBOutlet weak var countryNamelbl: UITextField!
    @IBOutlet weak var fullNameLbl: UITextField!
    @IBOutlet weak var mobNumberlbl: UITextField!
    @IBOutlet weak var noofBulding: UITextField!
    @IBOutlet weak var landmark: UITextField!
    @IBOutlet weak var pincode: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var statelbl: UITextField!
    @IBOutlet weak var arealbl: UITextField!
    @IBOutlet weak var titleofaddresslbl: UILabel!

    weak var delegate: AddressVCDelegate?

    var isEditmode: Bool = false
    var exitingAddress: UserAddress?

    override func viewDidLoad() {
        super.viewDidLoad()
        editmode()
    }

    @IBAction func saveBtn(_ sender: UIButton) {
        if isEditmode {
            let addId = exitingAddress?.mobno ?? ""
            editAddress(phoneNo: addId)
        } else {
            addAddress()
        }

        delegate?.didAddOrUpdateAddress()
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddressVC {
    func editmode() {
        if isEditmode {
            self.titleofaddresslbl.text = "Edit your delivery address"
            self.countryNamelbl.text = self.exitingAddress?.country
            self.city.text = self.exitingAddress?.city
            self.statelbl.text = self.exitingAddress?.state
            self.pincode.text = self.exitingAddress?.pincode
            self.arealbl.text = self.exitingAddress?.area
            self.fullNameLbl.text = self.exitingAddress?.fullname
            self.mobNumberlbl.text = self.exitingAddress?.mobno
            self.noofBulding.text = self.exitingAddress?.houseno
            self.landmark.text = self.exitingAddress?.landmark
        } else {
            self.titleofaddresslbl.text = "Add your delivery address"
        }
    }
}

extension AddressVC {
    func addAddress() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDelegate.persistentContainer.viewContext
        let addressData = UserAddress(context: manageContext)

        addressData.country = self.countryNamelbl.text
        addressData.city = self.city.text
        addressData.state = self.statelbl.text
        addressData.pincode = self.pincode.text
        addressData.area = self.arealbl.text
        addressData.fullname = self.fullNameLbl.text
        addressData.mobno = self.mobNumberlbl.text
        addressData.houseno = self.noofBulding.text
        addressData.landmark = self.landmark.text

        do {
            try manageContext.save()
            debugPrint("Data Saved")
            clearForm()
        } catch let error as NSError {
            debugPrint(error)
        }
    }

    func editAddress(phoneNo: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<UserAddress>(entityName: "UserAddress")
        request.predicate = NSPredicate(format: "mobno == %@", phoneNo)

        do {
            let results = try managedContext.fetch(request)
            if let addressData = results.first {
                addressData.country = self.countryNamelbl.text
                addressData.city = self.city.text
                addressData.state = self.statelbl.text
                addressData.pincode = self.pincode.text
                addressData.area = self.arealbl.text
                addressData.fullname = self.fullNameLbl.text
                addressData.mobno = self.mobNumberlbl.text
                addressData.houseno = self.noofBulding.text
                addressData.landmark = self.landmark.text

                try managedContext.save()
                debugPrint("Address Edited")
            }
        } catch let error as NSError {
            debugPrint(error)
        }
    }
}

extension AddressVC {
    func clearForm() {
        self.countryNamelbl.text = ""
        self.city.text = ""
        self.statelbl.text = ""
        self.pincode.text = ""
        self.arealbl.text = ""
        self.fullNameLbl.text = ""
        self.mobNumberlbl.text = ""
        self.noofBulding.text = ""
        self.landmark.text = ""
    }
}
