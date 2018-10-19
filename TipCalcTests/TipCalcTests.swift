//
//  TipCalcTests.swift
//  TipCalcTests
//
//  Created by Bear Cahill on 10/18/18.
//  Copyright © 2018 Brainwash Inc. All rights reserved.
//

import XCTest
@testable import TipCalc

class TipCalcTests: XCTestCase {

    var vc : ViewController?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vc = ViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTip() {
        let tip = vc!.calculateTip(billAmt: 20.00, tipPerc: 0.1)
        XCTAssertEqual(tip, 2.0, "tip shoul be 2.0")
    }
    
    func testTotal() {
        let total = vc!.calculateTotal(billAmt: 20.00, tip: 3.0)
        XCTAssertEqual(total, 23.0, "total sd be 23")
    }
    
    func testBill() {
        let tf = UITextField()
        vc?.tfInput = tf
        vc!.tfInput.text = "$23.00"
        let ba = vc!.billAmount
        XCTAssertEqual(ba, 23.0, "bill amount sd be 23")
    }
    
    func testTipInput() {
        let sc = UISegmentedControl()
        sc.insertSegment(withTitle: "10%", at: 0, animated: false)
        sc.selectedSegmentIndex = 0
        vc?.scTipPercentage = sc
        let tipPerc = vc?.tipPercentage
        XCTAssertEqual(tipPerc, 0.1, "tip sd be 10%")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
