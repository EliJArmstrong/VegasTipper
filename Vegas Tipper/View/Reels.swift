//
//  reels.swift
//  Vegas Tipper
//
//  Created by Eli Armstrong on 10/3/18.
//  Copyright © 2018 Eli Armstrong. All rights reserved.
//

import UIKit

class Reels: UIPickerView {

    
    var taxAmount: Int = 0
    
    // ========================================================================================================================================
    // Picker View Functions
    // ========================================================================================================================================
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PICKER_DATA_SIZE
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row % 10)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let stringNumber = "\(pickerView.selectedRow(inComponent: 0) % 10)\(pickerView.selectedRow(inComponent: 1) % 10)\(pickerView.selectedRow(inComponent: 2) % 10)"
        taxAmount = Int(stringNumber)!
        let position = PICKER_DATA_SIZE/2 + (row % 10)
        pickerView.selectRow(position, inComponent: component, animated: false)
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = String(row % 10)
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 26.0)!,NSAttributedString.Key.foregroundColor:UIColor.black])
        pickerLabel.attributedText = myTitle
        let hue = CGFloat(row % 10)/CGFloat(NUMBERS.count)
        pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness:1.0, alpha: 1.0)
        pickerLabel.textAlignment = .center
        return pickerLabel
    }

}
