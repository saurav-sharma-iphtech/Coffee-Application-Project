//
//  CartViewCell.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 13/05/25.
//

import UIKit

class CartViewCell: UITableViewCell {

    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusbtn: UIButton!
    @IBOutlet weak var cupcount: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var cupSize: UILabel!
    @IBOutlet weak var viewContant: UIView!
    @IBOutlet weak var pricelbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        justSetup()
    }
    
    func justSetup(){
        viewContant.layer.cornerRadius = 10
//        viewContant.clipsToBounds = true
        imgview.layer.cornerRadius = 10
    }
    
    
}
