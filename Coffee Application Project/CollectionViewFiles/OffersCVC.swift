//
//  OffersCVC.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 14/05/25.
//

import UIKit

class OffersCVC: UICollectionViewCell {
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var coffeename: UILabel!
    
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        view.layer.cornerRadius = 10
        img.layer.cornerRadius = 10
    }

}
