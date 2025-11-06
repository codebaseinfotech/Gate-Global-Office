//
//  MyStepsVC.swift
//  Gate Global
//
//  Created by iMac on 06/11/25.
//

import UIKit

class MyStepsVC: UIViewController {
    
    @IBOutlet weak var tblViewMySteps: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblViewMySteps.register(UINib(nibName: "MyStepsTblViewCell", bundle: nil), forCellReuseIdentifier: "MyStepsTblViewCell")
        tblViewMySteps.delegate = self
        tblViewMySteps.dataSource = self
        tblViewMySteps.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedHomeTab(_ sender: Any) {
        let vc = HomeVC()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
}

extension MyStepsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblViewMySteps.dequeueReusableCell(withIdentifier: "MyStepsTblViewCell") as! MyStepsTblViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
