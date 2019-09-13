//
//  Calculate.swift
//  CountOnMe
//
//  Created by Elodie-Anne Parquer on 09/08/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

enum MathOperator {
    case plus
    case minus
    case times
    case obelus
}

class Calculate {
    
    var calculText: String = "1 + 1 = 2" {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("calculText"), object: nil, userInfo: ["calculText": calculText])
        }
    }
    
    var expressionHaveDivisonByZero: Bool {
        var tempElements = elements
        while tempElements.contains("/") {
            guard let divisionIndex = tempElements.firstIndex(of: "/") else {return false}
            guard !(tempElements[divisionIndex+1] == "0") else {return true}
            tempElements[divisionIndex] = ""
        }
        return false
    }
    
    var elements: [String] {
        return calculText.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "x"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "x"
    }
    
    var expressionHaveResult: Bool {
        return calculText.firstIndex(of: "=") != nil
    }
    
//    func isItDecimal() -> Bool {
//        var isDecimal = true
//        for _ in calculText {
//            if calculText.contains(".") {
//                isDecimal = true
//            } else {
//                return false
//            }
//        }
//        return isDecimal
//    }
    
    func addNewNumber(numberText: String) {
        if expressionHaveResult {
            calculText = ""
        }
        
        calculText.append(numberText)
    }
    
    func addOperator(operators: MathOperator) {
        if expressionHaveResult {
           NotificationCenter.default.post(name: Notification.Name("displayAlert"), object: nil, userInfo: ["message" : "!"])
        } else if canAddOperator {
            switch operators {
            case .plus:
                calculText.append(" + ")
            case .minus:
                calculText.append(" - ")
            case .times:
                calculText.append(" x ")
            case .obelus:
                calculText.append(" / ")
            }
        } else {
            NotificationCenter.default.post(name: Notification.Name("displayAlert"), object: nil, userInfo: ["message" : "Un opérateur est déja mis !"])
        }
    }
    
    func priorityCalcul(expression: [String]) -> [String] {
        var tempExpression = expression
        
        while tempExpression.contains("x") || tempExpression.contains("/") {
            if let index = tempExpression.firstIndex(where: {$0 == "x" || $0 == "/" }) {
               let operand = tempExpression[index]
                guard let left = Float(tempExpression[index-1]) else { return []}
                guard let right = Float(tempExpression[index+1]) else {return []}
                let result: Float
                if operand == "x" {
                    result = left * right
                } else {
                   result = left / right
                }
                tempExpression[index-1] = String(result)
                tempExpression.remove(at: index+1)
                tempExpression.remove(at: index)
            }
            
        }
        return tempExpression
    }
    
    func resetCalcul() {
        calculText.removeAll()
    }
    
    func equal() {
        guard expressionIsCorrect else {
            NotificationCenter.default.post(name: Notification.Name("displayAlert"), object: nil, userInfo: ["message" : "Entrez une expression correcte !"])
            return
        }
        
        guard expressionHaveEnoughElement else {
            NotificationCenter.default.post(name: Notification.Name("displayAlert"), object: nil, userInfo: ["message" : "Démarrez un nouveau calcul !"])
            return
        }
        
        guard !expressionHaveDivisonByZero else {
            NotificationCenter.default.post(name: Notification.Name("displayAlert"), object: nil, userInfo: ["message" : "Il est impossible de faire une divsion par 0 !"])
            calculText = String()
            return
        }
        
        // Create local copy of operations
        var operationsToReduce = priorityCalcul(expression: elements)
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            guard let left = Float(operationsToReduce[0]) else {return}
            let operand = operationsToReduce[1]
            guard let right = Float(operationsToReduce[2]) else {return}
            
            let result: Float
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: return
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        calculText.append(" = \(operationsToReduce.first!)")
    }
    
}