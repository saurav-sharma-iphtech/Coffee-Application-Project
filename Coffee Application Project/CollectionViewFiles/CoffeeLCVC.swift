//
//  CoffeeLCVC.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 14/05/25.
//

import UIKit

class CoffeeLCVC: UICollectionViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var img: UIImageView!
  
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var csub: UILabel!
    @IBOutlet weak var coffeen: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.cornerRadius = 10
        img.layer.cornerRadius = 10
    }

}
