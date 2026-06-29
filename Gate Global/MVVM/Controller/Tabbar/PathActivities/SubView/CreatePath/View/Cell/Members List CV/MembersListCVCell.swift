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
    
    @IBOutlet weak var viewDelete: UIView!
    @IBOutlet weak var viewCheck: UIView!
    @IBOutlet weak var viewCheckBorder: UIView!
    
    var tappedDelete: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func tappedDeleteMember(_ sender: Any) {
        tappedDelete?()
    }
    

}
