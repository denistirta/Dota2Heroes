//
//  UIButton+Resize.swift
//  YUKK
//
//  Created by DenisTirta on 10/02/21.
//  Copyright © 2021 Gustaman. All rights reserved.
//

import UIKit

class UIButtonResize : UIButton {

    @IBInspectable var iPhoneFontSize:CGFloat = 0 {
        didSet {
            overrideFontSize(fontSize: iPhoneFontSize)
        }
    }
    
    func overrideFontSize(fontSize:CGFloat){
        let currentFontName = self.titleLabel?.font.fontName
        var calculatedFont: UIFont?
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        switch height {
        case 480.0: //Iphone 3,4,SE => 3.5 inch
            calculatedFont = UIFont(name: currentFontName ?? "", size: fontSize * 0.8)
            self.titleLabel?.font = calculatedFont
            break
        case 568.0: //iphone 5, 5s => 4 inch
            calculatedFont = UIFont(name: currentFontName ?? "", size: fontSize * 0.9)
            self.titleLabel?.font = calculatedFont
            break
        case 667.0: //iphone 6, 6s => 4.7 inch
            calculatedFont = UIFont(name: currentFontName ?? "", size: fontSize)
            self.titleLabel?.font = calculatedFont
            break
        case 736.0: //iphone 6s+ 6+ => 5.5 inch
            calculatedFont = UIFont(name: currentFontName ?? "", size: fontSize)
            self.titleLabel?.font = calculatedFont
            break
        default:
            break
        }
    }

}

