//
//  CollectionHerosList.swift
//  Dota2Heroes
//
//  Created by DenisTirta on 12/08/21.
//

import UIKit
import SDWebImage
import CHTCollectionViewWaterfallLayout
import SwiftyJSON

protocol CollectionHerosListDelegate{
    func actionDetail(value: ListHeros?)
}

class CollectionHerosList: UITableViewCell {

    var delegate: CollectionHerosListDelegate?
    @IBOutlet weak var collectionList: UICollectionView!
    @IBOutlet weak var aspect: NSLayoutConstraint!
    
    var flowLayout = CHTCollectionViewWaterfallLayout()
    var aspectRation = NSLayoutConstraint()
    
    var list: [ListHeros]?
    var listFilter: [ListHeros]?
    var width = CGFloat()
    
    var attribute = ["str", "agi", "int"]
    var selectedAttribute = -1
    
    var search = String()
    
    var collectionHeight: CGFloat {
        collectionList.reloadData()
        collectionList.layoutIfNeeded()
        return collectionList.contentSize.height + 50
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.width = self.collectionList.bounds.width
    }
        
    func setupColletion(){
        collectionList.delegate = self
        collectionList.dataSource = self
        collectionList.backgroundColor = UIColor.clear
        collectionList.isScrollEnabled = false
        collectionList.register(UINib(nibName: cellHeroList.className, bundle: nil), forCellWithReuseIdentifier: cellHeroList.className)

        let flowLayout = CHTCollectionViewWaterfallLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 24, left: 16, bottom: 16, right: 16)
        flowLayout.minimumColumnSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.columnCount = 3
        collectionList.collectionViewLayout = flowLayout
        
        listFilter = list
        
        if selectedAttribute > -1{
            listFilter = filterAttribut(search: attribute[selectedAttribute])
        }
        
        if !search.isEmpty{
            listFilter = filterName(search: search)
        }
        
        aspectRation = NSLayoutConstraint(item: self.collectionList as Any,
                                          attribute: NSLayoutConstraint.Attribute.height,
                                          relatedBy: NSLayoutConstraint.Relation.equal,
                                          toItem: self.collectionList!,
                                          attribute: NSLayoutConstraint.Attribute.width,
                                          multiplier: collectionHeight / self.width,
                                          constant: 0)
        let newConstraint = aspectRation
        self.collectionList.removeConstraint(aspect)
        self.collectionList.addConstraint(newConstraint)
        self.collectionList.layoutIfNeeded()
        aspect = newConstraint

        self.collectionList.collectionViewLayout.invalidateLayout()
        collectionList.reloadData()
    }
        
    private func filterAttribut(search: String) -> [ListHeros]?{
        let searchModel = self.listFilter?.filter { result in
            return result.primaryAttr?.lowercased().contains(search.lowercased()) ?? false
        }
        return searchModel
    }
    
    private func filterName(search: String) -> [ListHeros]?{
        let searchModel = self.listFilter?.filter { result in
            return result.localizedName?.lowercased().contains(search.lowercased()) ?? false
        }
        return searchModel
    }
    
    private func sorting() -> [ListHeros]?{
        let sortedFilter = self.listFilter?.sorted { $0.baseMana ?? 0 > $1.baseMana ?? 0 }
        return sortedFilter
    }
        
}

extension CollectionHerosList: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listFilter?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellHeroList.className, for: indexPath) as! cellHeroList

        cell.valueImg?.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.valueImg.sd_setImage(with: URL(string: "\(BaseURL)\(self.listFilter?[indexPath.row].img ?? "")"), placeholderImage: UIImage(named: "icDefault"), options: .refreshCached)

        cell.nameHero.text = self.listFilter?[indexPath.row].localizedName ?? ""
        
        switch self.listFilter?[indexPath.row].primaryAttr {
        case "str":
            cell.icAttribute.image = UIImage(named: "hero_strength")
        case "agi":
            cell.icAttribute.image = UIImage(named: "hero_agility")
        case "int":
            cell.icAttribute.image = UIImage(named: "hero_intelligence")
        default:
            cell.icAttribute.image = UIImage(named: "")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.actionDetail(value: self.listFilter?[indexPath.row])
    }
}

