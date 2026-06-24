//
//  MembersListCVCell.swift
//  Pathrium
//
//  Created by Ankit on 24/06/26.
//

import UIKit

class MembersListCVCell: UICollectionViewCell {
    
    @IBOutlet weak var viewMainAdd: UIView!
    @IBOutlet weak var viewMainMembers: UIView!
    @IBOutlet weak var lblMemberFirstLetter: UILabel!
    @IBOutlet weak var lblMemberName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func tappedDeleteMember(_ sender: Any) {
    }
    

}
