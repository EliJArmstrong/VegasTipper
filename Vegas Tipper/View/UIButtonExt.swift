//
//  UIButtonExt.swift
//  extensions_dance_party
//
//  Created by Eli Armstrong on 5/23/18.
//  Copyright © 2018 Eli Armstrong. All rights reserved.
//

import UIKit

extension UIButton{
    
    // Makes the UIButton wiggle for a short time via animation
    func wiggle(){
        let wiggleAnim = CABasicAnimation(keyPath: "position")
        wiggleAnim.duration = 0.05
        wiggleAnim.repeatCount = 5
        wiggleAnim.autoreverses = true
        wiggleAnim.fromValue = CGPoint(x: self.center.x - 4.0, y: self.center.y)
        wiggleAnim.toValue = CGPoint(x: self.center.x + 4.0, y: self.center.y)
        
        layer.add(wiggleAnim, forKey: "position")
    }
    
    // makes the button dim for a short time via animation
    func dim(){
        UIView.animate(withDuration: 0.15, animations: {
            self.alpha = 0.75
        }) { (finished) in
            UIView.animate(withDuration: 0.15, animations: {
                self.alpha = 1.0
            })
        }
    }
    
    // cause the buttons background to change colors when called.
    func colorize(){
        let randomNumberArray = generateRandomNumbers(quantity: 3)
        let randomColor = UIColor(red: randomNumberArray[0]/255, green: randomNumberArray[1]/255, blue: randomNumberArray[2]/255, alpha: 1.0)
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = randomColor
        }
    }
    
    // Generates a random array of CGFloat numbers.
    // paramter (quantity): The number of elements to be add to the CGFloat array.
    func generateRandomNumbers(quantity: Int) -> [CGFloat]{
        
        var randomNumberArray = [CGFloat]()
        
        for _ in 1...quantity{
            let randomNumber = CGFloat(arc4random_uniform(255))
            randomNumberArray.append(randomNumber)
        }
        
        return randomNumberArray
    }
}
