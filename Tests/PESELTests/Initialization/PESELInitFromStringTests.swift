//
//  File.swift
//  
//
//  Created by Paweł Pela on 16/06/2021.
//

import XCTest
@testable import PESEL

final class PESELInitFromStringTests: XCTestCase {
    func testInitializesFromValidStringWithoutError() {
        for validNumber in validTestNumbers {
            XCTAssertNoThrow(try PESEL(validNumber))
            XCTAssertNotNil(try? PESEL(validNumber))
        }
    }
    
    func testFailsToInitializeForInvalidStringWithError() {
        let invalidStrings = [
            "",
            "invalid",
            "123",
            "1234",
            "🤦‍♂️",
            "🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️",
            "-1234567",
            "123456789011",
            "11 chars..."
        ]
        
        for invalidString in invalidStrings {
            XCTAssertThrowsError(try PESEL(invalidString), "Did not throw error for \(invalidString)")
        }
    }
    
    func testFailsToInitializeForInvalidMonthWithError() {
        let invalidNumbers = [
            "73000815658",
            "73993815658",
            "73143815658",
            "73163815658",
            "73333815658",
            "73533815658",
            "73733815658",
            "73933815658",
            "73953815658",
        ]
        
        for invalidNumber in invalidNumbers {
            XCTAssertThrowsError(try PESEL(invalidNumber), "Did not throw error for \(invalidNumber)")
        }
    }
    
    func testFailsToInitializeForInvalidDayWithError() {
        let invalidTestNumbers = [
            73013215658,
            92113478766,
            83045644385,
            80038699621,
            90117578893,
            85123888763,
            50060047112,
            93074343891,
            62109883818,
            61049993689,
            87088832478,
        ].map { String($0) }
        
        for invalidNumber in invalidTestNumbers {
            XCTAssertThrowsError(try PESEL(invalidNumber), "Did not throw error for \(invalidNumber)")
        }
    }
    
    func testFailsToInitializeForInvalidDayInMonthWithError() {
        let invalidTestNumbers = [
            73023015658,
            73023115658,
            73043115658,
            73063115658,
            73093115658,
            73113115658,
            73223015658,
            73223115658,
            73243115658,
            73263115658,
            73293115658,
            73313115658,
            73423015658,
            73423115658,
            73443115658,
            73463115658,
            73493115658,
            73513115658,
            73623015658,
            73623115658,
            73643115658,
            73663115658,
            73693115658,
            73713115658,
            73823015658,
            73823115658,
            73843115658,
            73863115658,
            73893115658,
            73913115658,
        ].map { String($0) }
        
        for invalidNumber in invalidTestNumbers {
            XCTAssertThrowsError(try PESEL(invalidNumber), "Did not throw error for \(invalidNumber)")
        }
    }
    
    func testFailsToInitializeForInvalidDayInFebruaryWithError() {
        let invalidTestNumbers = [
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
        
        for invalidNumber in invalidTestNumbers {
            XCTAssertThrowsError(try PESEL(invalidNumber), "Did not throw error for \(invalidNumber)")
        }
    }
    
    func testFailsToInitializeWhenInvalidChecksumWithError() {
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
    
    let validTestNumbers = [
        73010815658,
        92111278766,
        83040744385,
        80030699621,
        90111578893,
        85122888763,
        50061147112,
        93071943891,
        62100383818,
        61041593689,
        87082532478,
        86011469887,
        84102398991,
        67041312156,
        60101642378,
        72090391173,
        57080168487,
        78051416758,
        67071772131,
        47121868643,
        96070736172,
        70102364731,
        72082884649,
        91042754152,
        68010566826,
        90080526747,
        92122874979,
        47082914728,
        59093029849,
        77051331847,
        59082151427,
        86040471183,
        65042125412,
        52072014155,
        89011098833,
        76112454639,
        84010926815,
        91050737282,
        66011664765,
        97010179589,
        65061377119,
        82073195696,
        46090165564,
        54010876564,
        96070133788,
        73011849445,
        77090297191,
        53101686529,
        80031555535,
        94081756624,
        68012326651,
        66071844646,
        69110888313,
        69062187252,
        84080858649,
        93032536195,
        63091617449,
        49111672663,
        71012172719,
        62072885213,
        74112264344,
        55033077596,
        63042531385,
        99061725641,
        62030731567,
        98070558286,
        83112325878,
        53031869193,
        59093097664,
        89061214643,
        70051415621,
        83121867831,
        66090578542,
        87123122367,
        59122555464,
        92061591492,
        48121152956,
        57082064125,
        61111861924,
        62112537728,
        58042577877,
        69050858841,
        86072523942,
        90011974795,
        55072892826,
        90011531174,
        75032473476,
        92061692537,
        46090134625,
        72121725995,
        53081344192,
        63051521711,
        92081739757,
        46042887991,
        65051611658,
        85030469593,
        57012285389,
        72073152883,
        72041319935,
        51041576137,
        55083015126,
        74102547716,
    ].map { String($0) } + [
        "04261644564",
        "00323074881",
        "03310787599",
        "05282158489",
        "02320516474",
        "03273086162",
        "03212254467",
    ]
}
