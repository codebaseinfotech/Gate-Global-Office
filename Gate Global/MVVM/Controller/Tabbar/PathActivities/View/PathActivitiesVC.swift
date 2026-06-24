//
//  PathActivitiesVC.swift
//  Gate Global
//
//  Created by iMac on 06/11/25.
//

import UIKit

class PathActivitiesVC: UIViewController {

    @IBOutlet weak var tblViewPaths: UITableView!
    
    let viewModel = PathActivitiesVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblViewPaths.register(UINib(nibName: "PathsTblViewCell", bundle: nil), forCellReuseIdentifier: "PathsTblViewCell")
        tblViewPaths.delegate = self
        tblViewPaths.dataSource = self
        tblViewPaths.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        viewModel.onSuccess = { [self] in
            print("Data:", self.viewModel.paths)
            DispatchQueue.main.async {
                self.tblViewPaths.reloadData()
            }
        }
        
        viewModel.onError = { error in
            print("Error:", error)
        }
        
        viewModel.fetchPaths()
        // Do any additional setup after loading the view.
    }

    @IBAction func clickedHomeTab(_ sender: Any) {
        let vc = HomeVC()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func clickedMessageTab(_ sender: Any) {
    }
    
    @IBAction func clickedStepsTab(_ sender: Any) {
        let vc = MyStepsVC()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func clickedPathTab(_ sender: Any) {
        let vc = PathActivitiesVC()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func tappedCreatePath(_ sender: Any) {
        let vc = CreatePathVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tappedSideMenu(_ sender: Any) {
        showSideMenu()
    }
    
}

extension PathActivitiesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.paths.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblViewPaths.dequeueReusableCell(withIdentifier: "PathsTblViewCell") as! PathsTblViewCell
        
        let path = viewModel.paths[indexPath.row]
        
        cell.lblName.text = path.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
