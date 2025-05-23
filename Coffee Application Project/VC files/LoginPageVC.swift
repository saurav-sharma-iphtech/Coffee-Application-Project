//
//  LoginPageVC.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 01/05/25.
//

import UIKit



class LoginPageVC: UIViewController ,UITextFieldDelegate, CountrySelectionDelegate{

    
    @IBOutlet weak var CountryCodeTxt: UITextField!
    @IBOutlet weak var PhoneNumberTxt: UITextField!
    var UserPhoneNumber :Int?
    var UserCountryCode : Int?
    public var generatedOTP :Int?
    var enterdata :String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        CountryCodeTxt.delegate = self
    }
    
    @IBAction func btnSkip(_ sender: UIButton) {
        UserDefaults.standard.set("true", forKey: "accessTokenKey")
        

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let b = storyboard.instantiateViewController(withIdentifier: "UITabBarController") as? UITabBarController {
            
            b.navigationItem.hidesBackButton = true
            navigationController?.pushViewController(b, animated: true)
        }

    }
    
    @IBAction func LoginBtn(_ sender: UIButton) {
        
        UserPhoneNumber = Int(PhoneNumberTxt.text ?? "")
        guard UserPhoneNumber != nil else{
            
            showAlert(message: "Please input Your Number...!!")
            return
        }
        let CountryCode = CountryCodeTxt.text ?? ""
        let PhoneNumber = PhoneNumberTxt.text ?? ""
        generatedOTP = Int.random(in: 1000...9999);
        print("Generated OTP: \(generatedOTP ?? 0)")
        enterdata = CountryCode + " - " + PhoneNumber
        pageNavigator()
    }
    

}

extension LoginPageVC{
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if let secondVC = storyboard?.instantiateViewController(withIdentifier: "CountryVC") as? CountryVC {
//
//            secondVC.delegate = self
//            navigationController?.pushViewController(secondVC, animated: true)
//        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let  secondVC = storyboard.instantiateViewController(withIdentifier: "CountryVC") as? CountryVC {
            secondVC.delegate = self
        
            
            if let sheet = secondVC.sheetPresentationController {
                sheet.detents = [
                    .large()    // Full screen
                ]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 20
            }
            
            self.present(secondVC, animated: true, completion: nil)
        }
        return false
    }

   //CountrySelectionDelegate
    func didSelectCountry(_ country: String) {
        CountryCodeTxt.text = country
    }
}

extension LoginPageVC{
    
    func pageNavigator(){
        if let navigaterPage = storyboard?.instantiateViewController(withIdentifier: "OTPVC") as? OTPVC{
            navigaterPage.recevedOtp = generatedOTP
            navigaterPage.enterdNo = enterdata ?? ""
            navigationController?.pushViewController(navigaterPage, animated: true)
        }
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert,animated: true)
        
    }
    
    
}
