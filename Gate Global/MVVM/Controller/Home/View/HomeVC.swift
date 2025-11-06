//
//  HomeVC.swift
//  Gate Global
//
//  Created by iMac on 04/11/25.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var collectionVIewRecentSteps: UICollectionView!
    
    @IBOutlet weak var collectionViewUpcomingEvents: UICollectionView!
    
    @IBOutlet weak var collectionVIewPathActivities: UICollectionView!
    
    @IBOutlet weak var tblViewDayStream: UITableView!
    
    @IBOutlet weak var dayStreamHeightConst: NSLayoutConstraint!
    
    let SlidarsectionInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    let SlidaritemsPerRow : CGFloat = 1.1
    var SlidarflowLayout: UICollectionViewFlowLayout {
        let _SlidarflowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.SlidarsectionInsets.left * (self.SlidaritemsPerRow + 1)
            let availableWidth = self.collectionVIewRecentSteps.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.SlidaritemsPerRow
            
            _SlidarflowLayout.itemSize = CGSize(width: widthPerItem, height: 340)
            
            _SlidarflowLayout.sectionInset = self.SlidarsectionInsets
            _SlidarflowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
            _SlidarflowLayout.minimumInteritemSpacing = 5
            _SlidarflowLayout.minimumLineSpacing = 10
        }
        
        // edit properties here
        return _SlidarflowLayout
    }
    
    let UpcomingsectionInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    let UpcomingitemsPerRow : CGFloat = 1.0
    var UpcomingflowLayout: UICollectionViewFlowLayout {
        let _UpcomingflowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.UpcomingsectionInsets.left * (self.UpcomingitemsPerRow + 1)
            let availableWidth = self.collectionViewUpcomingEvents.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.UpcomingitemsPerRow
            
            _UpcomingflowLayout.itemSize = CGSize(width: 100, height: 100)
            
            _UpcomingflowLayout.sectionInset = self.UpcomingsectionInsets
            _UpcomingflowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
            _UpcomingflowLayout.minimumInteritemSpacing = 5
            _UpcomingflowLayout.minimumLineSpacing = 5
        }
        
        // edit properties here
        return _UpcomingflowLayout
    }
    
    let PathsectionInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    let PathitemsPerRow : CGFloat = 1.2
    var PathflowLayout: UICollectionViewFlowLayout {
        let _PathflowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.PathsectionInsets.left * (self.PathitemsPerRow + 1)
            let availableWidth = self.collectionVIewPathActivities.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.PathitemsPerRow
            
            _PathflowLayout.itemSize = CGSize(width: widthPerItem, height: 455)
            
            _PathflowLayout.sectionInset = self.PathsectionInsets
            _PathflowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
            _PathflowLayout.minimumInteritemSpacing = 10
            _PathflowLayout.minimumLineSpacing = 10
        }
        
        // edit properties here
        return _PathflowLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // collection
        collectionVIewRecentSteps.register(UINib(nibName: "RecentStepsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecentStepsCollectionViewCell")
        collectionVIewRecentSteps.delegate = self
        collectionVIewRecentSteps.dataSource = self
        collectionVIewRecentSteps.collectionViewLayout = SlidarflowLayout
        
        collectionViewUpcomingEvents.register(UINib(nibName: "UpcomingEventsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingEventsCollectionViewCell")
        collectionViewUpcomingEvents.delegate = self
        collectionViewUpcomingEvents.dataSource = self
        collectionViewUpcomingEvents.collectionViewLayout = UpcomingflowLayout
        
        collectionVIewPathActivities.register(UINib(nibName: "PathActivitiesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PathActivitiesCollectionViewCell")
        collectionVIewPathActivities.delegate = self
        collectionVIewPathActivities.dataSource = self
        collectionVIewPathActivities.collectionViewLayout = PathflowLayout
        
        tblViewDayStream.register(UINib(nibName: "DayStreamTableViewCell", bundle: nil), forCellReuseIdentifier: "DayStreamTableViewCell")
        tblViewDayStream.delegate = self
        tblViewDayStream.dataSource = self
        tblViewDayStream.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        // Do any additional setup after loading the view.
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey] {
                let newsize  = newvalue as! CGSize
                self.dayStreamHeightConst.constant = newsize.height
            }
        }
    }

}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionVIewRecentSteps {
            return 5
        } else if collectionView == collectionViewUpcomingEvents {
            return 10
        } else if collectionView == collectionVIewPathActivities {
            return 4
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionVIewRecentSteps {
            let cell = self.collectionVIewRecentSteps.dequeueReusableCell(withReuseIdentifier: "RecentStepsCollectionViewCell", for: indexPath) as! RecentStepsCollectionViewCell
            
            return cell
        } else if collectionView == collectionViewUpcomingEvents {
            let cell = self.collectionViewUpcomingEvents.dequeueReusableCell(withReuseIdentifier: "UpcomingEventsCollectionViewCell", for: indexPath) as! UpcomingEventsCollectionViewCell
            
            return cell
        } else if collectionView == collectionVIewPathActivities {
            let cell = self.collectionVIewPathActivities.dequeueReusableCell(withReuseIdentifier: "PathActivitiesCollectionViewCell", for: indexPath) as! PathActivitiesCollectionViewCell
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionVIewRecentSteps {
            let vc = MyStepsVC()
            self.navigationController?.pushViewController(vc, animated: false)
        } else if collectionView == collectionVIewPathActivities {
            let vc = PathActivitiesVC()
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
        
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblViewDayStream.dequeueReusableCell(withIdentifier: "DayStreamTableViewCell") as! DayStreamTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
