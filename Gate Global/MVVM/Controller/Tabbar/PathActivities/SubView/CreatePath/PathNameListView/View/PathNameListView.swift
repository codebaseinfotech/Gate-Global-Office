//
//  PathNameListView.swift
//  Gate Global
//
//  Created by Poojagabani on 05/05/26.
//

enum PathAction {
    case addNewPath
    case addNewTrack
    case addNewDestination
}

import UIKit

class PathNameListView: UIView {

    @IBOutlet weak var tblViewPathList: UITableView! {
        didSet {
            tblViewPathList.register(UINib(nibName: "PathNameListTblViewCell", bundle: nil), forCellReuseIdentifier: "PathNameListTblViewCell")
            tblViewPathList.dataSource = self
            tblViewPathList.delegate = self
        }
    }
    @IBOutlet weak var txtSearchPath: UITextField!
    @IBOutlet weak var btnAddNewPath: UIButton!
    
    private let nibName = String(describing: PathNameListView.self)
    
    var onAction: ((PathAction) -> Void)?
    var onSelect: ((String) -> Void)?
    
    var type: PathAction = .addNewPath {
        didSet {
            updateUI()
            tblViewPathList.reloadData()
        }
    }
    
    var pathName = ["D1 Alpha Complete4", "D1 Alpha Complete5", "D1 Alpha Complete6", "D1 Alpha Complete7"]
    var trackName = ["All", "Design Phase", "Design Track"]
    var destination = ["All", "UI Design", "UX Design"]
    
    let defaultOption = "All"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    private func configureView() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        
        updateUI()
    }
    
    func loadViewFromNib() -> UIView? {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func updateUI() {
        switch type {
        case .addNewPath:
            btnAddNewPath.setTitle("+ Add New Path", for: .normal)
            
        case .addNewTrack:
            btnAddNewPath.setTitle("+ Add New Track", for: .normal)
            
        case .addNewDestination:
            btnAddNewPath.setTitle("+ Add New Destination", for: .normal)
        }
    }
    
    @IBAction func tappedAddNewPath(_ sender: Any) {
        onAction?(type)
    }
    
}

extension PathNameListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .addNewPath:
            return pathName.count
        case .addNewTrack:
            return trackName.count
        case .addNewDestination:
            return destination.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblViewPathList.dequeueReusableCell(withIdentifier: "PathNameListTblViewCell") as! PathNameListTblViewCell
        
        switch type {
        case .addNewPath:
            cell.lblPathName.text = pathName[indexPath.row]
        case .addNewTrack:
            cell.lblPathName.text = trackName[indexPath.row]
        case .addNewDestination:
            cell.lblPathName.text = destination[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedValue = ""
        
        switch type {
        case .addNewPath:
            selectedValue = pathName[indexPath.row]
        case .addNewTrack:
            selectedValue = trackName[indexPath.row]
        case .addNewDestination:
            selectedValue = destination[indexPath.row]
        }
        
        onSelect?(selectedValue)
    }
}
