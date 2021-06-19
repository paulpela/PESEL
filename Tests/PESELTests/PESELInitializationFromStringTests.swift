//
//  File.swift
//  
//
//  Created by Paweł Pela on 16/06/2021.
//

import XCTest
@testable import PESEL

final class PESELInitializationFromStringTests: XCTestCase {
    struct ValidData {
        let year: Int
        let month: PESEL.Month
        let day: Int
        
        var birthday: Date? {
            Date.from(year: year, month: month.rawValue, day: day)
        }
    }
    
    func testInitializesFromCorrectNumber() {
        let validTestData: [String:ValidData] = [
            "73111816477": ValidData(year: 1973, month: .november, day: 18),
            "80012056279": ValidData(year: 1980, month: .january, day: 20),
            "54031785799": ValidData(year: 1954, month: .march, day: 17),
            "64040822765": ValidData(year: 1964, month: .april, day: 8),
            "81051153329": ValidData(year: 1981, month: .may, day: 11),
            "51052726457": ValidData(year: 1951, month: .may, day: 27),
            "60020586612": ValidData(year: 1960, month: .february, day: 5),
            "04261644564": ValidData(year: 2004, month: .june, day: 16),
            "00323074881": ValidData(year: 2000, month: .december, day: 30),
            "03310787599": ValidData(year: 2003, month: .november, day: 7),
            "05282158489": ValidData(year: 2005, month: .august, day: 21),
            "02320516474": ValidData(year: 2002, month: .december, day: 5),
            "03273086162": ValidData(year: 2003, month: .july, day: 30),
            "03212254467": ValidData(year: 2003, month: .january, day: 22),
            "05322599241": ValidData(year: 2005, month: .december, day: 25),
            "04220764731": ValidData(year: 2004, month: .february, day: 7),
            "02303089164": ValidData(year: 2002, month: .october, day: 30),
            "01312064656": ValidData(year: 2001, month: .november, day: 20),
            "04230489619": ValidData(year: 2004, month: .march, day: 4),
            "01280355941": ValidData(year: 2001, month: .august, day: 3),
            "03260412242": ValidData(year: 2003, month: .june, day: 4),
            "01312691159": ValidData(year: 2001, month: .november, day: 26),
            "02321938974": ValidData(year: 2002, month: .december, day: 19),
            "01252089245": ValidData(year: 2001, month: .may, day: 20),
            "04321652618": ValidData(year: 2004, month: .december, day: 16),
            "05232787477": ValidData(year: 2005, month: .march, day: 27),
            // TODO: add for additional covered centuries
        ]
        
        for (pesel, validationData) in validTestData {
            XCTAssertNoThrow(try PESEL(pesel), "Failed for \(pesel)")
            XCTAssertNotNil(try? PESEL(pesel), "Failed for \(pesel)")
            
            XCTAssertEqual(try PESEL(pesel)?.number, pesel, "Failed for \(pesel)")
            XCTAssertEqual(try PESEL(pesel)?.year, validationData.year, "Failed for \(pesel)")
            XCTAssertEqual(try PESEL(pesel)?.month, validationData.month, "Failed for \(pesel)")
            XCTAssertEqual(try PESEL(pesel)?.day, validationData.day, "Failed for \(pesel)")
            
            XCTAssertEqual(try PESEL(pesel)?.birthday, validationData.birthday, "Failed for \(pesel)")
        }
    }
    
    func testFailsToInitializeWithNonNumericString() {
        let invalidTestData = [
            "",
            "invalid",
            "some string",
            "🤦‍♂️",
            "🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️",
            "11 chars...",
        ]
        
        for invalidNumber in invalidTestData {
            XCTAssertThrowsError(try PESEL(invalidNumber), "Did not throw for \(invalidNumber)")
        }
    }
    
    func testFailsToInitializeWithTooShortString() {
        let invalidTestData = [
            "123",
            "1234",
            "🤦‍♂️",
            "-1234567",
            "0123456789"
        ]
        
        for invalidNumber in invalidTestData {
            XCTAssertThrowsError(try PESEL(invalidNumber), "Did not throw for \(invalidNumber)")
        }
    }
    
    func testFailsToInitializeWithTooLongString() {
        let invalidTestData = [
            "🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️",
            "1234567890112",
        ]
        
        for invalidNumber in invalidTestData {
            XCTAssertThrowsError(try PESEL(invalidNumber), "Did not throw for \(invalidNumber)")
        }
    }
    
    func testFailsToInitializeWithInvalidMonth() {
        let invalidTestData = [
            "73000815658",
            "73993815658",
        ]
        
        for invalidNumber in invalidTestData {
            XCTAssertThrowsError(try PESEL(invalidNumber), "Did not throw for \(invalidNumber)")
        }
    }
    
    func testFailsToInitializeWithInvalidDay() {
        let invalidTestData = [
            "73143815658",
            "73163815658",
            "73333815658",
            "73533815658",
            "73733815658",
            "73933815658",
            "73953815658",
            "73023015658",
            "73023115658",
            "73043115658",
            "73063115658",
            "73093115658",
            "73113115658",
            "73223015658",
            "73223115658",
            "73243115658",
            "73263115658",
            "73293115658",
            "73313115658",
            "73423015658",
            "73423115658",
            "73443115658",
            "73463115658",
            "73493115658",
            "73513115658",
            "73623015658",
            "73623115658",
            "73643115658",
            "73663115658",
            "73693115658",
            "73713115658",
            "73823015658",
            "73823115658",
            "73843115658",
            "73863115658",
            "73893115658",
            "73913115658",
        ]
        
        for invalidNumber in invalidTestData {
            XCTAssertThrowsError(try PESEL(invalidNumber), "Did not throw for \(invalidNumber)")
        }
    }
    
    func testFailsToInitializeForInvalidDayInFebruary() {
        let invalidTestData = [
            25222915658,
            11022915658,
            21022915658,
            11422915658,
            21422915658,
            11622915658,
            21622915658,
            11822915658,
            21822915658,
        ].map { String($0) }
        
        for invalidNumber in invalidTestData {
            XCTAssertThrowsError(try PESEL(invalidNumber), "Did not throw error for \(invalidNumber)")
        }
    }
    
    func testFailsToInitializeWhenInvalidChecksum() {
        let invalidTestNumbers = [
            73010815655,
            92111278764,
            83040744382,
            80030699620,
            90111578891,
            85122888761,
            50061147115,
            93071943897,
            62100383810,
            61041593681,
            87082532473,
            86011469884,
            84102398995,
            67041312157,
            60101642379,
            72090391171,
            57080168482,
            78051416753,
            67071772134,
            47121868645,
        ].map { String($0) } + [
            "04261644566",
            "00323074882",
            "03310787590",
            "05282158481",
            "02320516473",
            "03273086166",
            "03212254469",
        ]
        
        for invalidNumber in invalidTestNumbers {
            XCTAssertThrowsError(try PESEL(invalidNumber), "Did not throw error for \(invalidNumber)")
        }
    }
}

extension Date {
    /// Create a date from specified parameters
    ///
    /// - Parameters:
    ///   - year: The desired year
    ///   - month: The desired month
    ///   - day: The desired day
    /// - Returns: A `Date` object
    static func from(year: Int, month: Int, day: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? nil
    }
}
