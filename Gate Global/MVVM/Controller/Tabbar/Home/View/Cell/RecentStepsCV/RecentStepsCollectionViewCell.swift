//
//  RecentStepsCollectionViewCell.swift
//  Gate Global
//
//  Created by iMac on 04/11/25.
//

import UIKit

class RecentStepsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblStepName: UILabel!
    @IBOutlet weak var txtViwqDes: UITextView!
    @IBOutlet weak var lblDueDate: UILabel!
    @IBOutlet weak var lblPath: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func clickedAttachment(_ sender: Any) {
    }
    
    @IBAction func clickedStatusUpdate(_ sender: Any) {
    }
    
    
}
