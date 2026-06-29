//
//  MemberListPopUpVC.swift
//  Pathrium
//
//  Created by Kenil on 29/06/26.
//

import UIKit

class MemberListPopUpVC: UIViewController {

    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var collectionViewMember: UICollectionView! {
        didSet {
            collectionViewMember.register(UINib(nibName: "MembersListCVCell", bundle: nil), forCellWithReuseIdentifier: "MembersListCVCell")
            collectionViewMember.delegate = self
            collectionViewMember.dataSource = self
        }
    }
    
    var memberListVM = MemberListVM()
    var selectedMember: [Member] = []
    var selectedIndexPaths: [IndexPath] = []
    var pathId: Int = 0
    
    // MARK: - view Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memberListVM.getMemberList()
        
        memberListVM.successMemberList = {
            
            for (_, obj) in self.selectedMember.enumerated() {
                let data = MemberUser(
                    userId: obj.id ?? 0,
                    name: obj.name ?? "",
                    email: obj.email ?? "",
                    avatar: ""
                )
                
                if obj.isOwner == true {
                    self.memberListVM.membersList.insert(data, at: 0)
                }
                
            }
            
            for (index, member) in self.memberListVM.membersList.enumerated() {
                
                if self.selectedMember.contains(where: { $0.id == member.userId }) {
                    self.selectedIndexPaths.append(IndexPath(row: index, section: 0))
                }
            }
            self.collectionViewMember.reloadData()
        }
        memberListVM.failureMemberList = { msg in
            self.setUpMakeToast(msg: msg)
        }
        
        memberListVM.successAddMember = {
            NotificationCenter.default.post(
                name: .addMemberSuccess,
                object: nil,
                userInfo: ["shareable_id": self.pathId]
            )
            self.dismiss(animated: false)
        }
        memberListVM.failureAddMember = { msg in
            self.setUpMakeToast(msg: msg)
        }

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Action Method
    @IBAction func tappedClose(_ sender: Any) {
        self.dismiss(animated: false)
    }
    @IBAction func tappedSubmit(_ sender: Any) {
        var userIds: [Int] = []

        for indexPath in selectedIndexPaths {
            let member = memberListVM.membersList[indexPath.item]
            userIds.append(member.userId ?? 0)
        }
        
        memberListVM.addMemberPath(userIds: userIds, pathId: pathId)
        
    }
    

     

}

extension MemberListPopUpVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memberListVM.membersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MembersListCVCell", for: indexPath) as! MembersListCVCell
        cell.viewMainAdd.isHidden = true
        cell.viewDelete.isHidden = true
        cell.viewMainMembers.isHidden = false

        let member = memberListVM.membersList[indexPath.item]

        cell.lblMemberFirstLetter.text = member.name.map { String($0.prefix(2)) } ?? ""
        cell.lblMemberName.text = member.name

        let isSelected = selectedIndexPaths.contains(indexPath)
        cell.viewCheckBorder.isHidden = !isSelected
        cell.viewCheck.isHidden = !isSelected

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectedIndexPaths.contains(indexPath) {
            if let index = selectedIndexPaths.firstIndex(of: indexPath) {
                selectedIndexPaths.remove(at: index)
            }
        } else {
            selectedIndexPaths.append(indexPath)
        }
        
        collectionView.reloadItems(at: [indexPath])
    }

    
}

extension MemberListPopUpVC: UICollectionViewDelegateFlowLayout {
    
    // MARK: - Insets
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    // MARK: - Vertical spacing
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // MARK: - Horizontal spacing
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // MARK: - Cell Size (3 columns)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing: CGFloat = 10
        let insets: CGFloat = 10 * 2
        
        let totalSpacing = (spacing * 2) + insets
        let width = (collectionView.frame.width - totalSpacing) / 3
        
        return CGSize(width: width, height: 95)
    }
}
