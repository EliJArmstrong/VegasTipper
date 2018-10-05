//
//  SettingsVC.swift
//  Vegas Tipper
//
//  Created by Eli Armstrong on 10/4/18.
//  Copyright © 2018 Eli Armstrong. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController{

    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var defaultTip: UILabel!
    
    @IBAction func stepperPressed(_ sender: Any) {
        defaultTip.text = stepper.value.description
        defaultTip.text?.insert("%", at: (defaultTip.text?.endIndex)!)
        defaults.set(Int(stepper.value), forKey: "defaultTip")
        defaults.synchronize()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepper.value = Double(defaults.integer(forKey: "defaultTip"))
        defaultTip.text = stepper.value.description
        defaultTip.text?.insert("%", at: (defaultTip.text?.endIndex)!)
        // Do any additional setup after loading the view.
    }

}
