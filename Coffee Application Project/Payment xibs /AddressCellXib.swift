//
//  AddressCellXib.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 21/05/25.
//

import UIKit

class AddressCellXib: UITableViewCell {

    @IBOutlet weak var deletebtn: UIButton!
    @IBOutlet weak var addAdddress: UIButton!
    @IBOutlet weak var chnageAddressbtn: UIButton!
    @IBOutlet weak var addresslbl: UILabel!
    @IBOutlet weak var personnamelbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
