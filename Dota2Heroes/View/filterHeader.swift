//
//  filterHeader.swift
//  Dota2Heroes
//
//  Created by DenisTirta on 12/08/21.
//

import UIKit
import CHTCollectionViewWaterfallLayout

@objc protocol filterHeaderDelegate {
    @objc optional func actionAttribute(index: Int)
}

class filterHeader: UIView {

    var delegate: filterHeaderDelegate?
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var collectionList: UICollectionView!
    
    var list = ["hero_strength", "hero_agility", "hero_intelligence"]
    var selectedAttribute = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupColletion()
    }
    
    func setupColletion(){
        collectionList.delegate = self
        collectionList.dataSource = self
        collectionList.backgroundColor = UIColor.clear
        collectionList.isScrollEnabled = false
        collectionList.register(UINib(nibName: filterCell.className, bundle: nil), forCellWithReuseIdentifier: filterCell.className)

        let flowLayout = CHTCollectionViewWaterfallLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        flowLayout.minimumColumnSpacing = 16
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.columnCount = 3
        collectionList.collectionViewLayout = flowLayout
    }
}

extension filterHeader: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCell.className, for: indexPath) as! filterCell

        cell.icFilter.image = UIImage(named: self.list[indexPath.row])
        
        if selectedAttribute == indexPath.row{
            cell.icFilter.alpha = 1
        }else{
            cell.icFilter.alpha = 0.4
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedAttribute == indexPath.row{
            delegate?.actionAttribute?(index: -1)
        }else{
            delegate?.actionAttribute?(index: indexPath.row)
        }
    }
}
