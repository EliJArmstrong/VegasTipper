//
//  ViewController.swift
//  Vegas Tipper
//
//  Created by Eli Armstrong on 10/3/18.
//  Copyright © 2018 Eli Armstrong. All rights reserved.
//

import UIKit

class TipVC: UIViewController{
    
    @IBOutlet weak var tipPercentPicker: UIPickerView!
    @IBOutlet weak var slotImg: UIImageView!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var borderImg: UIImageView!
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var redBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func reloadView(){
        let bill: Double = Double(billAmount.text!) ?? 0.0
        tipAmount.text = String(format: "$%.2f", bill * selectedTipAmount())
        totalAmount.text = String(format: "$%.2f", bill + (bill * selectedTipAmount()))
        setDefaults()
    }
    
    func setUpView(){
        
        tipPercentPicker.delegate = self
        tipPercentPicker.dataSource = self
        slotImg.layer.borderColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
        slotImg.layer.borderWidth = 5.0
        borderImg.layer.borderColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
        borderImg.layer.borderWidth = 51.5
        billAmount.becomeFirstResponder()
        
        
         print(defaults.bool(forKey: "past10Min"))
        
        if defaults.bool(forKey: "past10Min"){
            var defaultTip = defaults.integer(forKey: "defaultTip")
            for component in (0...2).reversed(){
                tipPercentPicker.selectRow(PICKER_DATA_SIZE/2 + (defaultTip % 10) , inComponent: component, animated: false)
                defaultTip /= 10
            }
        } else{
            loadDefaults()
        }
       
    }
    
    func setDefaults(){
        defaults.set(billAmount.text, forKey: "billAmountTxt")
        defaults.set(tipPercentPicker.selectedRow(inComponent: 0), forKey: "component0")
        defaults.set(tipPercentPicker.selectedRow(inComponent: 1), forKey: "component1")
        defaults.set(tipPercentPicker.selectedRow(inComponent: 2), forKey: "component2")
        defaults.synchronize()
    }
    
    func loadDefaults(){
        billAmount.text = defaults.string(forKey: "billAmountTxt")
        tipPercentPicker.selectRow(PICKER_DATA_SIZE/2 + defaults.integer(forKey: "component0") % 10, inComponent: 0, animated: false)
        tipPercentPicker.selectRow(PICKER_DATA_SIZE/2 + defaults.integer(forKey: "component1") % 10, inComponent: 1, animated: false)
        tipPercentPicker.selectRow(PICKER_DATA_SIZE/2 + defaults.integer(forKey: "component2") % 10, inComponent: 2, animated: false)
        reloadView()
    }
    
    @IBAction func calulateTip(_ sender: Any) {
        reloadView()
    }
    
    @IBAction func slotBtn(_ sender: Any) {
        
        redBtn.wiggle()
        redBtn.dim()
        
        for component in 1...2{
            tipPercentPicker.selectRow(tipPercentPicker.selectedRow(inComponent: component) + Int.random(in: 0 ... 20), inComponent: component, animated: true)
        }
        
        if tipPercentPicker.selectedRow(inComponent: 1) % 10 >= 5 && tipPercentPicker.selectedRow(inComponent: 2) % 10 > 0{
            tipPercentPicker.selectRow(PICKER_DATA_SIZE/2, inComponent: 0, animated: false)
            tipPercentPicker.selectRow(tipPercentPicker.selectedRow(inComponent: 0) + 20, inComponent: 0, animated: true)
        } else{
            tipPercentPicker.selectRow(PICKER_DATA_SIZE/2 + Int.random(in: 0 ... 1), inComponent: 0, animated: false)
            tipPercentPicker.selectRow(tipPercentPicker.selectedRow(inComponent: 0) + 20, inComponent: 0, animated: true)
        }
        setDefaults()
        reloadView()
    }
    
    func selectedTipAmount() -> Double{
        let stringNumber = "\(tipPercentPicker.selectedRow(inComponent: 0) % 10)\(tipPercentPicker.selectedRow(inComponent: 1) % 10)\(tipPercentPicker.selectedRow(inComponent: 2) % 10)"
        return Double(stringNumber)! / 100
    }

    
}

extension TipVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        reloadView()
        let position = PICKER_DATA_SIZE/2 + (row % 10)
        pickerView.selectRow(position, inComponent: component, animated: false)
        setDefaults()
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

