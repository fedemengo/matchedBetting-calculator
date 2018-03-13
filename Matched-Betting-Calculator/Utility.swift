//
//  Utility.swift
//  Matched-Betting-Calculator
//
//  Created by Federico Mengozzi on 13/03/2018.
//  Copyright © 2018 Federico Mengozzi. All rights reserved.
//

import Foundation

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

class Utility {
    static let ROUND: Double = 100.0
    
    static func parseDouble(string: String) -> Double {
        if string == "" {
            return 0.0
        }
        else {
            return string.doubleValue
        }
    }
    
    static func roundDouble(x: Double) -> Double {
        return Double(round(ROUND*x)/ROUND)
    }
}
