//
//  PostsCVC.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 15/05/25.
//

import UIKit

class PostsCVC: UICollectionViewCell {

    @IBOutlet weak var imgposts: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgposts.layer.cornerRadius = 10
    }

}
