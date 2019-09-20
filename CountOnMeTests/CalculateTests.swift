//
//  CalculateTests.swift
//  CountOnMeTests
//
//  Created by Elodie-Anne Parquer on 05/08/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe
final class CalculateTests: XCTestCase {
    
    var calculate: Calculate!

    override func setUp() {
        super.setUp()
        calculate = Calculate()
    }
    
    func testGivenCalculTextAddition_WhenIsExpressionAdditionLaunch_ThenSendUpToDateIsFalse() {
        calculate.addNewNumber(numberText: "3")
        calculate.addOperator(operators: .plus)
        calculate.addNewNumber(numberText: "1")
        calculate.equal()
        
       XCTAssertEqual(calculate.calculText, "3 + 1 = 4.0")
    }
    
    func testGivenCalculTextSubstraction_WhenIsExpressionSubstractionLaunch_ThenSendUpToDateIsFalse() {
        calculate.addNewNumber(numberText: "5")
        calculate.addOperator(operators: .minus)
        calculate.addNewNumber(numberText: "2")
        calculate.equal()
        
        XCTAssertEqual(calculate.calculText, "5 - 2 = 3.0")
    }
    
    func testGivenCalculTextMultiplication_WhenIsExpressionMultiplicationLaunch_ThenSendUpToDateIsFalse() {
        calculate.addNewNumber(numberText: "5")
        calculate.addOperator(operators: .times)
        calculate.addNewNumber(numberText: "2")
        calculate.equal()
        
        XCTAssertEqual(calculate.calculText, "5 x 2 = 10.0")
    }
    
    func testGivenCalculTextDivision_WhenIsExpressionDivisionLaunch_ThenSendUpToDateIsFalse() {
        calculate.addNewNumber(numberText: "6")
        calculate.addOperator(operators: .obelus)
        calculate.addNewNumber(numberText: "2")
        calculate.equal()
        
        XCTAssertEqual(calculate.calculText, "6 / 2 = 3.0")
    }
    
    func testGivenCalculTextDivisionByzero_WhenIsExpressionDivisonByZeroLaunch_ThenSendUpToDateIsFalse() {
        calculate.addNewNumber(numberText: "5")
        calculate.addOperator(operators: .obelus)
        calculate.addNewNumber(numberText: "0")
        calculate.equal()
        
        XCTAssertFalse(calculate.expressionHaveDivisonByZero)
    }
    
    func testGivenCalculTextAddOperator_WhenTwoOperatorAreTapped_ThenShouldNotification() {
        calculate.addNewNumber(numberText: "5")
        calculate.addOperator(operators: .minus)
        calculate.addOperator(operators: .minus)
        calculate.equal()
        
        XCTAssertEqual(calculate.calculText, "5 - ")
    }
    
    func testGivenExpressionHaveEnoughElement_WhenMissElements_ThenShouldNotification() {
        calculate.addNewNumber(numberText: "5")
        calculate.equal()
        
        XCTAssertEqual(calculate.calculText, "5")
    }
    
    func testGivenError_WhenTwoOperatorsEqualAreTapped_ThenShouldNotification() {
        calculate.addNewNumber(numberText: "1")
        calculate.addOperator(operators: .plus)
        calculate.addNewNumber(numberText: "1")
        calculate.equal()
        calculate.equal()
        
        XCTAssertEqual(calculate.calculText, "1 + 1 = 2.0")
    }
    
    func testGivenResetCalculText_WhenRestCalculTextIsLaunch_ThenShouldNotification() {
        calculate.addNewNumber(numberText: "5")
        calculate.addOperator(operators: .times)
        calculate.addNewNumber(numberText: "2")
        calculate.equal()
        calculate.resetCalcul()
        
        XCTAssertEqual(calculate.calculText, "")
    }
    
    func testGivenAddOperator_WhenOperationHaveResult_ThenShouldNotification() {
        calculate.addNewNumber(numberText: "5")
        calculate.addOperator(operators: .times)
        calculate.addNewNumber(numberText: "2")
        calculate.equal()
        calculate.addOperator(operators: .minus)
        
        XCTAssertEqual(calculate.calculText, "5 x 2 = 10.0")
    }

}
