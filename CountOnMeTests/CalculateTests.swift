//
//  CalculateTests.swift
//  CountOnMeTests
//
//  Created by Elodie-Anne Parquer on 05/08/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe
class CalculateTests: XCTestCase {
    
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
        
       XCTAssertEqual(calculate.calculText, "3 + 1 = 4")
    }
    
    func testGivenCalculTextSubstraction_WhenIsExpressionSubstractionLaunch_ThenSendUpToDateIsFalse() {
        calculate.addNewNumber(numberText: "5")
        calculate.addOperator(operators: .minus)
        calculate.addNewNumber(numberText: "2")
        calculate.equal()
        
        XCTAssertEqual(calculate.calculText, "5 - 2 = 3")
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
    
    func testGivenError_When_ThenShouldNotification() {
        calculate.addNewNumber(numberText: "1")
        calculate.addOperator(operators: .plus)
        calculate.addNewNumber(numberText: "1")
        calculate.equal()
        calculate.equal()
        
        XCTAssertEqual(calculate.calculText, "1 + 1 = 2")
    }

}
