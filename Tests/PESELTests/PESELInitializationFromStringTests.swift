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
        let pin: Int // Personal Identification Number
        let sex: PESEL.Sex
        
        var birthday: Date? {
            Date.from(year: year, month: month.rawValue, day: day)
        }
    }
    
    func testInitializesFromCorrectNumber() {
        let validTestData: [String:ValidData] = [
            "73111816477": ValidData(year: 1973, month: .november, day: 18, pin: 1647, sex: .male),
            "80012056279": ValidData(year: 1980, month: .january, day: 20, pin: 5627, sex: .male),
            "54031785799": ValidData(year: 1954, month: .march, day: 17, pin: 8579, sex: .male),
            "64040822765": ValidData(year: 1964, month: .april, day: 8, pin: 2276, sex: .female),
            "81051153329": ValidData(year: 1981, month: .may, day: 11, pin: 5332, sex: .female),
            "51052726457": ValidData(year: 1951, month: .may, day: 27, pin: 2645, sex: .male),
            "60020586612": ValidData(year: 1960, month: .february, day: 5, pin: 8661, sex: .male),
            "04261644564": ValidData(year: 2004, month: .june, day: 16, pin: 4456, sex: .female),
            "00323074881": ValidData(year: 2000, month: .december, day: 30, pin: 7488, sex: .female),
            "03310787599": ValidData(year: 2003, month: .november, day: 7, pin: 8759, sex: .male),
            "05282158489": ValidData(year: 2005, month: .august, day: 21, pin: 5848, sex: .female),
            "02320516474": ValidData(year: 2002, month: .december, day: 5, pin: 1647, sex: .male),
            "03273086162": ValidData(year: 2003, month: .july, day: 30, pin: 8616, sex: .female),
            "03212254467": ValidData(year: 2003, month: .january, day: 22, pin: 5446, sex: .female),
            "05322599241": ValidData(year: 2005, month: .december, day: 25, pin: 9924, sex: .female),
            "04220764731": ValidData(year: 2004, month: .february, day: 7, pin: 6473, sex: .male),
            "02303089164": ValidData(year: 2002, month: .october, day: 30, pin: 8916, sex: .female),
            "01312064656": ValidData(year: 2001, month: .november, day: 20, pin: 6465, sex: .male),
            "04230489619": ValidData(year: 2004, month: .march, day: 4, pin: 8961, sex: .male),
            "01280355941": ValidData(year: 2001, month: .august, day: 3, pin: 5594, sex: .female),
            "03260412242": ValidData(year: 2003, month: .june, day: 4, pin: 1224, sex: .female),
            "01312691159": ValidData(year: 2001, month: .november, day: 26, pin: 9115, sex: .male),
            "02321938974": ValidData(year: 2002, month: .december, day: 19, pin: 3897, sex: .male),
            "01252089245": ValidData(year: 2001, month: .may, day: 20, pin: 8924, sex: .female),
            "04321652618": ValidData(year: 2004, month: .december, day: 16, pin: 5261, sex: .male),
            "05232787477": ValidData(year: 2005, month: .march, day: 27, pin: 8747, sex: .male),
            "84111804478": ValidData(year: 1984, month: .november, day: 18, pin: 447, sex: .male),
            "20322704222": ValidData(year: 2020, month: .december, day: 27, pin: 422, sex: .female),
            "20471615921": ValidData(year: 2120, month: .july, day: 16, pin: 1592, sex: .female),
            "78422710508": ValidData(year: 2178, month: .february, day: 27, pin: 1050, sex: .female),
            "41450204497": ValidData(year: 2141, month: .may, day: 2, pin: 449, sex: .male),
            "23660105012": ValidData(year: 2223, month: .june, day: 1, pin: 501, sex: .male),
            "09692719764": ValidData(year: 2209, month: .september, day: 27, pin: 1976, sex: .female),
            "77833018625": ValidData(year: 1877, month: .march, day: 30, pin: 1862, sex: .female),
            "90900303781": ValidData(year: 1890, month: .october, day: 3, pin: 378, sex: .female),
        ]
        
        for (pesel, validationData) in validTestData {
            XCTAssertNoThrow(try PESEL(pesel), "Failed for \(pesel)")
            XCTAssertNotNil(try? PESEL(pesel), "Failed for \(pesel)")
            
            XCTAssertEqual(try PESEL(pesel)?.number, pesel, "Failed for \(pesel)")
            XCTAssertEqual(try PESEL(pesel)?.year, validationData.year, "Failed for \(pesel)")
            XCTAssertEqual(try PESEL(pesel)?.month, validationData.month, "Failed for \(pesel)")
            XCTAssertEqual(try PESEL(pesel)?.day, validationData.day, "Failed for \(pesel)")
            
            XCTAssertEqual(try PESEL(pesel)?.birthday, validationData.birthday, "Failed for \(pesel)")
            
            XCTAssertEqual(try PESEL(pesel)?.personalIdentificationNumber, validationData.pin, "Failed for \(pesel)")
            
            XCTAssertEqual(try PESEL(pesel)?.sex, validationData.sex, "Failed for \(pesel)")
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
    
    func testFailsToInitializeIfPINInvalid() {
        let invalidTestNumbers = [
            "04261600006",
            "00323000002",
            "03310700000",
            "05282100001",
            "02320500003",
            "03273000006",
            "03212200009",
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
