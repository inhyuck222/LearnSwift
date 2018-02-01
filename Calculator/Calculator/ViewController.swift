//
//  ViewController.swift
//  Calculator
//
//  Created by 임인혁 on 2017. 11. 9..
//  Copyright © 2017년 inorv. All rights reserved.
//

import UIKit

var calculatorCount = 0

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    private var userIsInTheMiddleOfTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorCount += 1
        print("remain calculator count : \(calculatorCount)")
        
        brain.addUnaryOperation(symbol: "Z"){ [weak weakSelf = self] in
            weakSelf?.display.textColor = UIColor.red
            return sqrt($0)
        }
    }
    
    deinit {
        calculatorCount -= 1
        print("remain calculator count : \(calculatorCount)")
    }
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    private var displayValue : Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    var savedProgram : CalculratorBrain.PropertyList?
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil{
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
    private var brain = CalculratorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathmaticalSymbol = sender.currentTitle{
            brain.performOperation(symbol: mathmaticalSymbol)
        }
        displayValue = brain.result
    }
    
}
