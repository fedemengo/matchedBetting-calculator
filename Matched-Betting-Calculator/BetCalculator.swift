//
//  BetCalculator.swift
//  Matched-Betting-Calculator
//
//  Created by Federico Mengozzi on 13/03/2018.
//  Copyright © 2018 Federico Mengozzi. All rights reserved.
//

import Foundation

class BetManager {
    static func isValid(backStack: Double, backOdds: Double, backComm: Double, layOdds: Double, layComm: Double) -> Bool {
        return !(backStack == 0.0 || backStack.isNaN || backOdds == 0.0 || backOdds.isNaN || layOdds.isNaN || layOdds == 0.0 || layOdds.isNaN || layComm.isNaN)
    }
}

class BetCalculator {
    
    var layStake: Double!
    
    var backWins: Double!
    var layLoses: Double!
    
    var backLoses: Double!
    var layWins: Double!
    
    var profit: Double!
    
    func initBet(betType: BET, backStake: Double, backOdds: Double, backCom: Double, layOdds: Double, layCom: Double) -> Void {
        
        if(betType == BET.QUAL){
            self.layStake = Utility.roundDouble(x: (backStake*(backOdds-backCom))/(layOdds-layCom))
            self.backLoses = Utility.roundDouble(x: -backStake)
        }
        else {
            self.layStake = Utility.roundDouble(x:(backStake*(backOdds-1-backCom))/(layOdds-layCom))
            self.backLoses = -0.0
        }
            
        self.backWins = Utility.roundDouble(x: backStake*(backOdds-1-backCom))
        self.layLoses = Utility.roundDouble(x: -self.layStake*(1-layOdds))
            
        self.layWins = Utility.roundDouble(x: layStake*(1-layCom))
        
        self.profit = Utility.roundDouble(x: min(backWins-layLoses, backLoses+layWins))
    }
    
    func getLayStake() -> Double {
        return self.layStake!
    }
    
    func caseBackWins() -> String {
        return "\(self.backWins!) - \(self.layLoses!) = \(Utility.roundDouble(x: self.backWins!-self.layLoses!))"
    }
    
    func caseLayWins() -> String {
        return "\(self.backLoses!) + \(self.layWins!) = \(Utility.roundDouble(x: self.backLoses!+self.layWins!))"
    }
    
    func getProfit() -> Double {
        return self.profit!
    }
}
