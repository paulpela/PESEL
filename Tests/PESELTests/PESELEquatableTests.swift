//
//  File.swift
//  
//
//  Created by Paweł Pela on 19/06/2021.
//

import Foundation

import XCTest
@testable import PESEL

final class PESELEquatableTests: XCTestCase {
    func testCanCompare() {
        let testNumbers = [
            "73111816477": "73111816477",
            "80012056279": "80012056279",
        ]
        
        for (number1, number2) in testNumbers {
            let pesel1 = try? PESEL(number1)
            let pesel2 = try? PESEL(number2)
            
            XCTAssert(pesel1 == pesel2, "Failed for \(String(describing: pesel1)) == \(String(describing: pesel2))")
        }
    }
    
    func testCanCompareNotEqual() {
        let testNumbers = [
            "73111816477": "80012056279",
            "80012056279": "73111816477",
        ]
        
        for (number1, number2) in testNumbers {
            let pesel1 = try? PESEL(number1)
            let pesel2 = try? PESEL(number2)
            
            XCTAssert(pesel1 != pesel2, "Failed for \(String(describing: pesel1)) == \(String(describing: pesel2))")
        }
    }
}
