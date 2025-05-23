//
//  OptionsTypeCell.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 22/05/25.
//

import UIKit

class OptionsTypeCell: UITableViewCell {

    @IBOutlet weak var banklogo: UIImageView!
    @IBOutlet weak var btnPay: UIButton!
    @IBOutlet weak var bankname: UILabel!
  
    @IBOutlet weak var btnprice: UIButton!
    @IBOutlet weak var logo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
