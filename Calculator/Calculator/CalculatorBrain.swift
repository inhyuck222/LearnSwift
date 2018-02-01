//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 임인혁 on 2018. 1. 18..
//  Copyright © 2018년 inorv. All rights reserved.
//

import Foundation

class CalculratorBrain{
    
    private var accumulator = 0.0
    private var internalProgram = [AnyObject]()
    
    public func setOperand(operand : Double){
        accumulator = operand
        internalProgram.append(operand as AnyObject)
    }
    
    public func addUnaryOperation(symbol : String, operation : @escaping (Double) -> Double){
        operations[symbol] = Operation.UnaryOperation(operation)
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(Double.pi),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "×" : Operation.BinaryOperation({ $0*$1 }),
        "÷" : Operation.BinaryOperation({ $0/$1 }),
        "+" : Operation.BinaryOperation({ $0+$1 }),
        "−" : Operation.BinaryOperation({ $0-$1 }),
        "=" : Operation.Equals
    ]
    
    private enum Operation{
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    public func performOperation(symbol: String){
        internalProgram.append(symbol as AnyObject)
        if let operation = operations[symbol]{
            switch operation{
            case .Constant(let value) :
                accumulator = value
            case .UnaryOperation(let function) :
                accumulator = function(accumulator)
            case .BinaryOperation(let function) :
                excutePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction : function, firstOperand : accumulator)
            case .Equals :
                excutePendingBinaryOperation()
            }
        }
    }
    
    private func excutePendingBinaryOperation(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending : PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo{
        var binaryFunction : (Double, Double) -> Double
        var firstOperand : Double
    }
    
    typealias PropertyList = AnyObject
    
    var program : PropertyList {
        get{
            return internalProgram as AnyObject
        }
        set{
            if let arrayOfOps = newValue as? [AnyObject] {
                for op in arrayOfOps {
                    if let operand = op as? Double{
                        setOperand(operand: operand)
                    }else if let symbol = op as? String{
                        performOperation(symbol: symbol)
                    }
                }
            }
        }
    }
    
    var result : Double{
        get{
            return accumulator
        }
    }
    
}
