//
//  PathsTblViewCell.swift
//  Gate Global
//
//  Created by iMac on 06/11/25.
//

import UIKit

class PathsTblViewCell: UITableViewCell {
    
    @IBOutlet weak var lblPathName: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var imgBillboardUser: UIImageView!
    @IBOutlet weak var lblBillboardUserName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
