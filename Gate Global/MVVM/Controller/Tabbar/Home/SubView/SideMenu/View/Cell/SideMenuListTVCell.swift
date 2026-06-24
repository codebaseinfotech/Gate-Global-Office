//
//  SideMenuListTVCell.swift
//  Gate Global
//
//  Created by Ankit on 24/06/26.
//

import UIKit

class SideMenuListTVCell: UITableViewCell {
    
    @IBOutlet weak var imgMenuListIcon: UIImageView!
    @IBOutlet weak var lblMenuListName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
