//
//  Loading Page VC.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 01/05/25.
//

import UIKit

class Loading_Page_VC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(navigateToLoginPage), userInfo: nil, repeats: false)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(navigateToLoginPage), userInfo: nil, repeats: false)
    }
    
    
    
    
    @objc func navigateToLoginPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(identifier: "LoginPageVC") as? LoginPageVC{
            
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
    }
}
