//
//  RemoveMemberPopupVC.swift
//  Pathrium
//
//  Created by Kenil on 29/06/26.
//

import UIKit

class RemoveMemberPopupVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    
    var name: String = ""
    var clickedDelete: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        let fullText = "Are you sure you want to remove \"\(name)\" from this vault?"

        let attributedString = NSMutableAttributedString(
            string: fullText,
            attributes: [
                .font: UIFont.systemFont(ofSize: 15),
                .foregroundColor: UIColor.gray
            ]
        )

        let range = (fullText as NSString).range(of: name)
        if range.location != NSNotFound {
            attributedString.addAttribute(
                .font,
                value: UIFont.boldSystemFont(ofSize: 15),
                range: range
            )
        }

        lblTitle.attributedText = attributedString
        lblTitle.textAlignment = .center
        lblTitle.numberOfLines = 0

        // Do any additional setup after loading the view.
    }

    @IBAction func tappedCancel(_ sender: Any) {
        self.dismiss(animated: false)
    }
    @IBAction func tappedDelete(_ sender: Any) {
        clickedDelete?()
        self.dismiss(animated: false)
    }
    
     

}
