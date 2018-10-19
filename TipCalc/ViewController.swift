//
//  ViewController.swift
//  TipCalc
//
//  Created by Bear Cahill on 10/18/18.
//  Copyright © 2018 Brainwash Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var scTipPercentage: UISegmentedControl!
    
    @IBOutlet weak var lblTipOutput: UILabel!
    @IBOutlet weak var lblTotalOutput: UILabel!
    
    @IBOutlet weak var lblTipNextDollar: UILabel!
    @IBOutlet weak var lblTotalNextDollar: UILabel!
    
    
    let nf = NumberFormatter()
    let replaceChars = "$.,"
    
    var tipPercentage : Double {
        guard scTipPercentage != nil else { return 0.0 }
        let tipText = scTipPercentage.titleForSegment(at: scTipPercentage.selectedSegmentIndex)!
            .replacingOccurrences(of: "%", with: "")
        if let tipPerc = Double(tipText) {
            return tipPerc / 100.0
        }
        return 0.0
    }
    
    var billAmount : Double {
        guard tfInput != nil else { return 0.0 }
        if var input = tfInput.text {
            replaceChars.forEach { (char) in
                input = input.replacingOccurrences(of: "\(char)", with: "")
            }
            return (Double(input) ?? 0.0) / 100.0
        }
        return 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tfInput.becomeFirstResponder()
        nf.numberStyle = .currency
        lblTotalOutput.text = ""
        lblTipOutput.text = ""
        
        if let billAmt = UserDefaults.standard.string(forKey: "BillAmount") {
            tfInput.text = billAmt
            scTipPercentage.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "TipPercentage")
            calcValues()
        }
    }
    
    @IBAction func doTFValChanged(_ sender: UITextField) {
        calcValues()
    }
    
    func numToTextfield(val : Double) {
        tfInput.text = nf.string(from: val as NSNumber)
    }

    @IBAction func doSCTipPercentage(_ sender: UISegmentedControl) {
        calcValues()
    }
    
    func calcValues() {
        UserDefaults.standard.set(tfInput.text, forKey: "BillAmount")
        UserDefaults.standard.set(scTipPercentage.selectedSegmentIndex, forKey: "TipPercentage")
        
        numToTextfield(val: billAmount)
        
        let tip = calculateTip(billAmt: billAmount, tipPerc: tipPercentage)
        let total = calculateTotal(billAmt: billAmount, tip: tip)
        
        lblTipOutput.text = nf.string(from: tip as NSNumber)
        lblTotalOutput.text = nf.string(from: total as NSNumber)
        
        let nextDollar = Double(Int(tip) + 1)
        lblTipNextDollar.text = nf.string(from: nextDollar as NSNumber)
        lblTotalNextDollar.text = nf.string(from: (nextDollar + billAmount) as NSNumber)

    }

    func calculateTip(billAmt : Double, tipPerc : Double) -> Double {
        return billAmt * tipPerc
    }
    
    func calculateTotal(billAmt : Double, tip : Double) -> Double {
        return billAmt + tip
    }
}

