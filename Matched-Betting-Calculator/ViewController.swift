//
//  ViewController.swift
//  MatchedBet calc
//
//  Created by Federico Mengozzi on 11/03/2018.
//  Copyright © 2018 Federico Mengozzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    //@IBOutlet weak var calc: UIButton!
    
    /*
     @IBAction func calcAction(_ sender: Any) {
     let alert: UIAlertView = UIAlertView()
     alert.title = "Hello!"
     alert.message = "One or Two?"
     alert.addButton(withTitle: "One")
     alert.addButton(withTitle: "Two")
     alert.delegate = self  // set the delegate here
     alert.show()
     }
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        author.text = " @fedemengo"
        
        //calc.layer.cornerRadius = 5;
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
        resignFirstResponder()
    }
    
}

