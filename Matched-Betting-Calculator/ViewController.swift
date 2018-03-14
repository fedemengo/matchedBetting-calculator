//
//  ViewController.swift
//  MatchedBet calc
//
//  Created by Federico Mengozzi on 11/03/2018.
//  Copyright © 2018 Federico Mengozzi. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(_ r: Double,_ g: Double,_ b: Double,_ a: Double) {
        self.init(red: CGFloat(r/255), green: CGFloat(g/255), blue: CGFloat(b/255), alpha: CGFloat(a))
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var backStake: UITextField!
    @IBOutlet weak var backOdds: UITextField!
    @IBOutlet weak var backFee: UITextField!
    
    @IBOutlet weak var layOdds: UITextField!
    @IBOutlet weak var layFee: UITextField!

    @IBOutlet weak var layStake: UILabel!
    @IBOutlet weak var liability: UILabel!
    @IBOutlet weak var backWin: UILabel!
    @IBOutlet weak var layWin: UILabel!
    @IBOutlet weak var profit: UILabel!
    
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet var qualBetButton: RatioButton!
    @IBOutlet var freeBetButton: RatioButton!
    
    let calculator = BetCalculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        author.text = "\u{f09b} @fedemengo"
        
        initButton(btn: qualBetButton, betType: BET.QUAL, selected: true, otherBtn: freeBetButton)
        initButton(btn: freeBetButton, betType: BET.FREE, selected: false, otherBtn: qualBetButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func closeKey() {
        backStake.resignFirstResponder()
        backOdds.resignFirstResponder()
        backFee.resignFirstResponder()
        layOdds.resignFirstResponder()
        layFee.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeKey()
        calculate()
    }
    
    func initButton(btn: RatioButton, betType: BET, selected: Bool, otherBtn: RatioButton) -> Void {
        btn.layer.cornerRadius = btn.frame.width/2
        btn.isSelected = selected
        btn.bet = betType
        btn.buttons = [otherBtn]
        btn.addTarget(self, action:#selector(calculate), for: .touchUpInside)
    }
    
    func calculate() -> Void {
        let betType = (qualBetButton.isSelected ? qualBetButton.bet : freeBetButton.bet)
        let backStakeValue = Utility.parseDouble(string: backStake.text!)
        let backOddsValue = Utility.parseDouble(string: backOdds.text!)
        let backCommisionValue = Utility.parseDouble(string: backFee.text!)/100
        let layOddsValue = Utility.parseDouble(string: layOdds.text!)
        let layCommissionValue = Utility.parseDouble(string: layFee.text!)/100
        
        if BetManager.isValid(backStack: backStakeValue, backOdds: backOddsValue, backComm: backCommisionValue, layOdds: layOddsValue, layComm: layCommissionValue) {
            
            calculator.initBet(betType: betType!, backStake: backStakeValue, backOdds: backOddsValue, backCom: backCommisionValue, layOdds: layOddsValue, layCom: layCommissionValue)
            updateLabels(calculator: calculator)
        }
    }
    
    func updateLabels(calculator: BetCalculator) -> Void {
        layStake.text = "\(calculator.getLayStake())"
        liability.text = "\(calculator.getLiability())"
        backWin.text = calculator.caseBackWins()
        layWin.text = calculator.caseLayWins()
    
        profit.font = UIFont.boldSystemFont(ofSize: 17)
        profit.textColor = calculator.getProfit() > 0 ? UIColor(0.0, 204.0, 0.0, 1.0) : UIColor.red
        profit.text = "\(calculator.getProfit())"
    }
    
}

