//
//  HomeFirstCollectionViewCell.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 13/05/25.
//

import UIKit

class HomeFirstCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sliderImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sliderImg.layer.cornerRadius = 12
    }

}
