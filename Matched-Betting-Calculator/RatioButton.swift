//
//  RatioButton.swift
//  Matched-Betting-Calculator
//
//  Created by Federico Mengozzi on 12/03/2018.
//  Copyright © 2018 Federico Mengozzi. All rights reserved.
//

import Foundation
import UIKit

class RatioButton : UIButton {
    
    var buttons: Array<RatioButton>?
    var bet: BET!
    
    func unselectButtons(){
        
        if buttons != nil {
            self.isSelected = true
            
            for aButton:RatioButton in buttons! {
                aButton.isSelected = false
            }
        }
        else {
            toggleButton()
        }
    }
    
    override var isSelected: Bool {
        willSet (isSelected) {
            if(isSelected){
                self.backgroundColor = UIColor.green
                self.setTitleColor(UIColor.black, for: UIControlState.normal)
            }
            else {
                self.backgroundColor = UIColor.lightGray
                self.setTitleColor(UIColor.gray, for: UIControlState.normal)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.unselectButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton(){
        if self.isSelected {
            self.isSelected = false
        } else {
            self.isSelected = true
        }
    }
}
