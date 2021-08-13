//
//  HeaderDetailView.swift
//  Dota2Heroes
//
//  Created by DenisTirta on 13/08/21.
//

import UIKit

@objc protocol HeaderDetailViewDelegate{
    @objc optional func actionBack()
}

class HeaderDetailView: UIView {

    var delegate:HeaderDetailViewDelegate?
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var icAttribute: UIImageView!
    @IBOutlet weak var valueAttribute: UILabelResize!
    @IBOutlet weak var nameHero: UILabelResize!
    @IBOutlet weak var imgHero: UIImageView!
    
    @IBOutlet weak var labelType: UILabelResize!
    @IBOutlet weak var valueType: UILabelResize!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    @IBAction func pushBack(_ sender: Any) {
        delegate?.actionBack?()
    }
}
