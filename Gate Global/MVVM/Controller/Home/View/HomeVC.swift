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
    
    
    let SlidarsectionInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    let SlidaritemsPerRow : CGFloat = 1.1
    var SlidarflowLayout: UICollectionViewFlowLayout {
        let _SlidarflowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.SlidarsectionInsets.left * (self.SlidaritemsPerRow + 1)
            let availableWidth = self.collectionVIewRecentSteps.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.SlidaritemsPerRow
            
            _SlidarflowLayout.itemSize = CGSize(width: widthPerItem, height: 370)
            
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
        // Do any additional setup after loading the view.
    }



}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionVIewRecentSteps {
            return 5
        } else if collectionView == collectionViewUpcomingEvents {
            return 10
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
        }
        
        return UICollectionViewCell()
    }
    
    
}
