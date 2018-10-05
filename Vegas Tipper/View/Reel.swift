//
//  Reel.swift
//  Vegas Tipper
//
//  Created by Eli Armstrong on 10/3/18.
//  Copyright © 2018 Eli Armstrong. All rights reserved.
//

import UIKit

@IBDesignable
class Reel: UILabel {

    var attributedString: NSAttributedString
    var row: Int
    
    init(attributedString: NSAttributedString, row: Int){
        self.attributedString = attributedString
        self.row = row
    }
    
    override func awakeFromNib() {
        setUpView()
    }
    
    func setUpView(){
        let titleData = String(row % 10)
        let myTitle = self.attributedString
        pickerLabel.attributedText = myTitle
        let hue = CGFloat(row % 10)/CGFloat(NUMBERS.count)
        pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness:1.0, alpha: 1.0)
        pickerLabel.textAlignment = .center
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
}
