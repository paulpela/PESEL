//
//  File.swift
//  
//
//  Created by Paweł Pela on 19/06/2021.
//

import Foundation

import XCTest
@testable import PESEL

final class PESELComparableTests: XCTestCase {
    func testCanCompareFirstOneGreater() {
        let testData = [
            "80012056279": "73111816477",
            "54031785799": "51052726457",
            "04261644564": "60020586612",
            "20322704222": "01312691159",
        ]
        
        for (number1, number2) in testData {
            if let pesel1 = try? PESEL(number1)!, let pesel2 = try? PESEL(number2)! {
                XCTAssert(pesel1 > pesel2, "Failed for \(number1) > \(number2)")
            } else {
                XCTFail("Failed for \(number1) > \(number2)")
            }
        }
    }
}
