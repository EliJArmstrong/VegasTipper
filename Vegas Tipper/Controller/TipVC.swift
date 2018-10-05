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
    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var redBtn: UIButton!
    
    
    // ===============================================================
    //         _              ______ _     _ _                     _
    //        (_)             |  _  (_)   | | |                   | |
    //  __   ___  _____      _| | | |_  __| | |     ___   __ _  __| |
    //  \ \ / / |/ _ \ \ /\ / / | | | |/ _` | |    / _ \ / _` |/ _` |
    //   \ V /| |  __/\ V  V /| |/ /| | (_| | |___| (_) | (_| | (_| |
    //    \_/ |_|\___| \_/\_/ |___/ |_|\__,_\_____/\___/ \__,_|\__,_|
    //
    // ===============================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    
    // ==========================================================================
    //     ____ _                 _____                 _   _
    //    / ___| | __ _ ___ ___  |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
    //   | |   | |/ _` / __/ __| | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
    //   | |___| | (_| \__ \__ \ |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
    //    \____|_|\__,_|___/___/ |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
    //
    // =========================================================================
    
    // This function sets up the the UIView and checks for if the app has been idle for 10 minutes.
    func setUpView(){
        
        tipPercentPicker.delegate = self
        tipPercentPicker.dataSource = self
        slotImg.layer.borderColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
        slotImg.layer.borderWidth = 5.0
        borderImg.layer.borderColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
        borderImg.layer.borderWidth = 51.5
        billAmountField.becomeFirstResponder()
        
        // If the app has been open outside of 10 minutes then the default tip that was set in the settings.
        // Else the data that was set in the app at closing are reloaded and shown to the user.
        if defaults.bool(forKey: "past10Min"){
            billAmountField.text = ""
            var defaultTip = defaults.integer(forKey: "defaultTip")
            for component in (0...2).reversed(){
                tipPercentPicker.selectRow(PICKER_DATA_SIZE/2 + (defaultTip % 10) , inComponent: component, animated: false)
                defaultTip /= 10
            }
        } else{
            loadDefaults()
        }
    }
    
    // Reloads the view. This function is called when data is changed.
    func reloadView(){
        let bill: Double = Double(billAmountField.text!) ?? 0.0
        tipAmount.text = String(format: "$%.2f", bill * selectedTipAmount())
        totalAmount.text = String(format: "$%.2f", bill + (bill * selectedTipAmount()))
        setDefaults()
    }

    // This function takes the digits from the UIPicker and returns a Double in the form of a percentage decimal.
    func selectedTipAmount() -> Double{
        let stringNumber = "\(tipPercentPicker.selectedRow(inComponent: 0) % 10)\(tipPercentPicker.selectedRow(inComponent: 1) % 10)\(tipPercentPicker.selectedRow(inComponent: 2) % 10)"
        return Double(stringNumber)! / 100
    }
    
    // This function sets the defaults for persistent data.
    func setDefaults(){
        defaults.set(billAmountField.text, forKey: "billAmountTxt")
        defaults.set(tipPercentPicker.selectedRow(inComponent: 0), forKey: "component0")
        defaults.set(tipPercentPicker.selectedRow(inComponent: 1), forKey: "component1")
        defaults.set(tipPercentPicker.selectedRow(inComponent: 2), forKey: "component2")
        defaults.synchronize()
    }
    
    // This function loads the persistent data into the UI elements
    func loadDefaults(){
        billAmountField.text = defaults.string(forKey: "billAmountTxt")
        tipPercentPicker.selectRow(PICKER_DATA_SIZE/2 + defaults.integer(forKey: "component0") % 10, inComponent: 0, animated: false)
        tipPercentPicker.selectRow(PICKER_DATA_SIZE/2 + defaults.integer(forKey: "component1") % 10, inComponent: 1, animated: false)
        tipPercentPicker.selectRow(PICKER_DATA_SIZE/2 + defaults.integer(forKey: "component2") % 10, inComponent: 2, animated: false)
        reloadView()
    }
    
    
    // ========================================================================================================================================
    //                 _   _               ______                _   _
    //       /\       | | (_)             |  ____|              | | (_)
    //      /  \   ___| |_ _  ___  _ __   | |__ _   _ _ __   ___| |_ _  ___  _ __  ___
    //     / /\ \ / __| __| |/ _ \| '_ \  |  __| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
    //    / ____ \ (__| |_| | (_) | | | | | |  | |_| | | | | (__| |_| | (_) | | | \__ \
    //   /_/    \_\___|\__|_|\___/|_| |_| |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
    //
    //
    // ========================================================================================================================================
    
    // This function is called every time the text is entered into the billAmountField outlet.
    @IBAction func calulateTip(_ sender: Any) {
        reloadView()
    }
    
    // When the red button is pressed this function is called and will randomly choose an percentage.
    @IBAction func redBtnPressed(_ sender: Any) {
        
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
    


    
}


// ========================================================================================================================================
//  ______ _      _               _   _ _                ______                _   _
//  | ___ (_)    | |             | | | (_)               |  ___|              | | (_)
//  | |_/ /_  ___| | _____ _ __  | | | |_  _____      __ | |_ _   _ _ __   ___| |_ _  ___  _ __  ___
//  |  __/| |/ __| |/ / _ \ '__| | | | | |/ _ \ \ /\ / / |  _| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
//  | |   | | (__|   <  __/ |    \ \_/ / |  __/\ V  V /  | | | |_| | | | | (__| |_| | (_) | | | \__ \
//  \_|   |_|\___|_|\_\___|_|     \___/|_|\___| \_/\_/   \_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
//
// The Docs for the following functions can be seen in the quick help inspector
// ========================================================================================================================================

extension TipVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
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

