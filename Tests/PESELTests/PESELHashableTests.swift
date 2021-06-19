//
//  File.swift
//  
//
//  Created by Paweł Pela on 19/06/2021.
//

import Foundation

import XCTest
@testable import PESEL

final class PESELHashableTests: XCTestCase {
    func testIsHashable() {
        let testData = [
            "73111816477",
            "80012056279",
            "54031785799",
            "64040822765",
            "81051153329",
            "51052726457",
            "60020586612",
            "04261644564",
            "00323074881",
            "03310787599",
        ]
        
        for testNumber in testData {
            XCTAssertNotNil(try? PESEL(testNumber).hashValue, "Failed for \(testNumber)")
        }
    }
}
