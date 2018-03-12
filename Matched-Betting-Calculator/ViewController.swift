//
//  ViewController.swift
//  MatchedBet calc
//
//  Created by Federico Mengozzi on 11/03/2018.
//  Copyright © 2018 Federico Mengozzi. All rights reserved.
//

import UIKit

extension String {
    var floatValue: Float {
        let nf = NumberFormatter()
        nf.decimalSeparator = "."
        if let result = nf.number(from: self) {
            return result.floatValue
        } else {
            nf.decimalSeparator = ","
            if let result = nf.number(from: self) {
                return result.floatValue
            }
        }
        return Float.nan
    }
    
    var doubleValue:Double {
        let nf = NumberFormatter()
        nf.decimalSeparator = "."
        if let result = nf.number(from: self) {
            return result.doubleValue
        } else {
            nf.decimalSeparator = ","
            if let result = nf.number(from: self) {
                return result.doubleValue
            }
        }
        return Double.nan
    }
}

class ViewController: UIViewController {
    
    let ROUND: Double = 100.0
    
    @IBOutlet weak var backStake: UITextField!
    @IBOutlet weak var backOdds: UITextField!
    @IBOutlet weak var backFee: UITextField!
    
    @IBOutlet weak var layOdds: UITextField!
    @IBOutlet weak var layFee: UITextField!

    @IBOutlet weak var layStake: UILabel!
    @IBOutlet weak var backWin: UILabel!
    @IBOutlet weak var layWin: UILabel!
    @IBOutlet weak var profit: UILabel!
    
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet var qualifyingBetButton: RatioButton!
    @IBOutlet var freeBetButton: RatioButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        author.text = "\u{f09b} @fedemengo"
        
        qualifyingBetButton.layer.cornerRadius = qualifyingBetButton.frame.width/2
        freeBetButton.layer.cornerRadius = freeBetButton.frame.width/2
        
        qualifyingBetButton.isSelected = true
        freeBetButton.isSelected = false
        
        qualifyingBetButton?.buttons = [freeBetButton!]
        freeBetButton?.buttons = [qualifyingBetButton!]
        
        qualifyingBetButton.addTarget(self, action:#selector(calculate), for: .touchUpInside)
        freeBetButton.addTarget(self, action:#selector(calculate), for: .touchUpInside)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func resignFirstResponder() -> Bool {
        backStake.resignFirstResponder()
        backOdds.resignFirstResponder()
        backFee.resignFirstResponder()
        layOdds.resignFirstResponder()
        layFee.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch intercepted")
        resignFirstResponder()
        calculate()
    }
    
    func parseDouble(string: String) -> Double {
        if string == "" {
            return 0.0
        }
        else {
            return string.doubleValue
        }
    }
    
    func validate(bs: Double, bo: Double, bc: Double, lo: Double, lc: Double) -> Bool {
        if bs == 0.0 || bs.isNaN || bo == 0.0 || bo.isNaN || bc.isNaN || lo == 0.0 || lo.isNaN || lc.isNaN {
            return false;
        }
        return true;
    }
    
    func roundDouble(x: Double) -> Double {
        return Double(round(ROUND*x)/ROUND)
    }
    
    func calculate() -> Void {
        let isQualifyingBet = qualifyingBetButton.isSelected
        let backStakeValue = parseDouble(string: backStake.text!)
        let backOddsValue = parseDouble(string: backOdds.text!)
        let backCommisionValue = parseDouble(string: backFee.text!)
        let layOddsValue = parseDouble(string: layOdds.text!)
        let layCommissionValue = parseDouble(string: layFee.text!)
        
        if validate(bs: backStakeValue, bo: backOddsValue, bc: backCommisionValue, lo: layOddsValue, lc: layCommissionValue) {
            var layStakeValue: Double
            var backLose: Double
            
            if(isQualifyingBet){
                layStakeValue = roundDouble(x: (backStakeValue*(backOddsValue-backCommisionValue))/(layOddsValue-layCommissionValue))
                backLose = roundDouble(x: -backStakeValue)
            }
            else {
                layStakeValue = roundDouble(x:(backStakeValue*(backOddsValue-1-backCommisionValue))/(layOddsValue-layCommissionValue))
                backLose = -0.0
            }
            
            let backWins = roundDouble(x: backStakeValue*(backOddsValue-1-backCommisionValue))
            let layLose = roundDouble(x: -layStakeValue*(1-layOddsValue))
            
            let layWins = roundDouble(x: layStakeValue*(1-layCommissionValue))
            
            layStake.text = "\(layStakeValue)"
            backWin.text = "\(backWins) - \(layLose) = \(roundDouble(x: backWins-layLose))"
            layWin.text = "\(backLose) + \(layWins) = \(roundDouble(x: backLose+layWins))"
            profit.text = "\(roundDouble(x: min(backWins-layLose, backLose+layWins)))"
        }
    }
    
}

