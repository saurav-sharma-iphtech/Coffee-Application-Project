//
//  PaymentOptionCell.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 20/05/25.
//

import UIKit

class PaymentOptionCell: UITableViewCell {

    @IBOutlet weak var cardimg: UIImageView!
    @IBOutlet weak var paymenttypename: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
