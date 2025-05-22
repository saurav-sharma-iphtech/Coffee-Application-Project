//
//  OTPVC.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 01/05/25.
//

import UIKit
import MessageUI

class OTPVC: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var phoneNolbl: UILabel!
    @IBOutlet weak var OTPTxt1: UITextField!
    @IBOutlet weak var OTPTxt2: UITextField!
    @IBOutlet weak var OTPTxt3: UITextField!
    @IBOutlet weak var OTPTxt4: UITextField!
    
    var UserOTP : Int?
    var recevedOtp :Int?
    var resend :Bool = false
    var newGeneratedOTP :Int?
    var enterdNo :String = ""
    
    var isLoggedIn :Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        OTPTxt1.delegate = self
        OTPTxt2.delegate = self
        OTPTxt3.delegate = self
        OTPTxt4.delegate = self
        
        self.navigationItem.hidesBackButton = true
        phoneNolbl.text = enterdNo 
    }
    
    
    
    @IBAction func goToLoginBtn(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func ResendOTPbtn(_ sender: UIButton) {
        
        showAlert(message: "OTP Successfully Send")
        newGeneratedOTP = Int.random(in: 1000...9999)
        print(" New Generated OTP: \(newGeneratedOTP ?? 0)")
        
        resend = true
       clearForm()
        
    }
    
    @IBAction func VerifyBtn(_ sender: Any) {
        
        if resend == false{
            let one = OTPTxt1.text ?? ""
            let two = OTPTxt2.text ?? ""
            let three = OTPTxt3.text ?? ""
            let four = OTPTxt4.text ?? ""
            UserOTP = Int(one + two + three + four)
            guard UserOTP == recevedOtp else{
                showAlert(message: "please fill Correct OTP..!")
                clearForm()
                return
            }
            clearForm()
            navigationPage()
        }
        else{
            let one = OTPTxt1.text ?? ""
            let two = OTPTxt2.text ?? ""
            let three = OTPTxt3.text ?? ""
            let four = OTPTxt4.text ?? ""
            UserOTP = Int(one + two + three + four)
            guard UserOTP == newGeneratedOTP  else{
                showAlert(message: "please fill Correct OTP..!")
                clearForm()
                return
            }
            clearForm()
            navigationPage()
        }
        
    }
    
    
    
    
}
extension OTPVC{
    
    //Show Alert Message
    func showAlert(message: String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
    }
    
//    Navigate Page One VC to Another VC
//    func navigationPage(){
//        UserDefaults.standard.setValue(true, forKey:"accessTokenKey" )
//       print(" button was tappedd")
//        if let homePageNavigate = storyboard?.instantiateViewController(withIdentifier: "UITabBarController") as? UITabBarController{
//            homePageNavigate.navigationItem.hidesBackButton = true
//           navigationController?.pushViewController(homePageNavigate, animated:true)
//        }
//
//    }
    
    func navigationPage() {
        // Save login state
        UserDefaults.standard.set(true, forKey: "accessTokenKey")
        
        // Load UITabBarController from storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "UITabBarController") as? UITabBarController else {
            print("Failed to instantiate UITabBarController")
            return
        }

        // Set new rootViewController
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let navigationController = UINavigationController(rootViewController: tabBarController)
            sceneDelegate.window?.rootViewController = navigationController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }

    
    
    //clear form
    func clearForm(){
        OTPTxt1.text = ""
        OTPTxt2.text = ""
        OTPTxt3.text = ""
        OTPTxt4.text = ""
    }
}

extension OTPVC{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Allow only digits
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)

        // Calculate new length
        let currentText = textField.text ?? ""
        let newLength = currentText.count + string.count - range.length

        return allowedCharacters.isSuperset(of: characterSet) && newLength <= 1
    }
}


