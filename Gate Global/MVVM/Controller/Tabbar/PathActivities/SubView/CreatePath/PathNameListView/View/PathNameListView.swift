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
    var onSelect: ((String, Int) -> Void)?
    
    var type: PathAction = .addNewPath {
        didSet {
            updateUI()
            tblViewPathList.reloadData()
        }
    }
    
    var pathName: [PathModel] = [] {
        didSet {
            tblViewPathList.reloadData()
        }
    }
    
    var trackName: [Track] = [] {
        didSet {
            tblViewPathList.reloadData()
        }
    }
    var destination: [Destination] = [] {
        didSet {
            tblViewPathList.reloadData()
        }
    }
    
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
            cell.lblPathName.text = pathName[indexPath.row].name
            
        case .addNewTrack:
            cell.lblPathName.text = trackName[indexPath.row].name
            
        case .addNewDestination:
            cell.lblPathName.text = destination[indexPath.row].name
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedValue = ""
        var selectedId: Int = 0
        
        switch type {
        case .addNewPath:
            selectedValue = pathName[indexPath.row].name
            selectedId = pathName[indexPath.row].id
            
        case .addNewTrack:
            selectedValue = trackName[indexPath.row].name ?? ""
            selectedId = trackName[indexPath.row].id ?? 0
            
        case .addNewDestination:
            selectedValue = destination[indexPath.row].name ?? ""
            selectedId = destination[indexPath.row].id ?? 0

        }
        
        onSelect?(selectedValue, selectedId)
    }
}
