//
//  SideMenuVC.swift
//  Gate Global
//
//  Created by Ankit on 24/06/26.
//

import UIKit

protocol SideMenuDelegate: AnyObject {
    func hideSideMenu()
}

class SideMenuVC: UIViewController {
    
    @IBOutlet weak var lblUserFirstLatter: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var tblViewMenuList: UITableView! {
        didSet {
            tblViewMenuList.register(UINib(nibName: "SideMenuListTVCell", bundle: nil), forCellReuseIdentifier: "SideMenuListTVCell")
            tblViewMenuList.dataSource = self
            tblViewMenuList.delegate = self
        }
    }
    
    weak var delegate: SideMenuDelegate?
    
    var arrMenuList = ["Home", "Message", "Steps", "Path", "Notifications"]
    var arrMenuListIcon = ["ic_Home", "ic_Message", "ic_Steps", "ic_Path", "ic_notification"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUserData()
        // Do any additional setup after loading the view.
    }
    
    func setupUserData() {
        guard let user = GGUtilites.getCurrentUser() else { return }
        
        lblUserName.text = "\(user.firstName ?? "") \(user.lastName ?? "")"
        lblUserEmail.text = user.email
        
        if let firstChar = user.firstName?.first {
            lblUserFirstLatter.text = String(firstChar).uppercased()
        }
    }

    @IBAction func tappedLogout(_ sender: Any) {
        let vc = LogoutPopUpVC()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    

}

extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenuList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tblViewMenuList.dequeueReusableCell(
            withIdentifier: "SideMenuListTVCell",
            for: indexPath
        ) as! SideMenuListTVCell

        cell.lblMenuListName.text = arrMenuList[indexPath.row]
        cell.imgMenuListIcon.image = UIImage(named: arrMenuListIcon[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        delegate?.hideSideMenu()

        guard let homeVC = parent as? HomeVC else { return }

        switch indexPath.row {

        case 0:
            break

        case 1:
            let vc = MyStepsVC()
            homeVC.navigationController?.pushViewController(vc, animated: false)

        case 2:
            let vc = MyStepsVC()
            homeVC.navigationController?.pushViewController(vc, animated: false)

        case 3:
            let vc = PathActivitiesVC()
            homeVC.navigationController?.pushViewController(vc, animated: false)

        case 4:
            let vc = MyStepsVC()
            homeVC.navigationController?.pushViewController(vc, animated: false)

        default:
            break
        }
    }
}
