//
//  OrderedCVC.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 15/05/25.
//

import UIKit

class OrderedCVC: UICollectionViewCell {

    @IBOutlet weak var imgg: UIImageView!
    
    @IBOutlet weak var coffeename: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgg.layer.cornerRadius = 10
    }

}
