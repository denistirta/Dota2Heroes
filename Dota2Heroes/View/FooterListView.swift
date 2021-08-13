//
//  FooterListView.swift
//  Dota2Heroes
//
//  Created by DenisTirta on 12/08/21.
//

import UIKit

@objc protocol FooterListViewDelegate{
    @objc optional func actionFooter()
}

class FooterListView: UIView {

    var delegate: FooterListViewDelegate?
    @IBOutlet weak var btnFooter: UIButtonResize!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func pushFooter(_ sender: Any) {
        delegate?.actionFooter?()
    }
    
}
