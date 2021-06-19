import Foundation

public struct PESEL: Equatable {
    enum ValidationError: Error {
        case invalidNumber
        case numberTooShort(Int)
        case numberTooLong(Int)
        case invalidCharacters
        case invalidMonth(String)
        case invalidDay(String)
        case invalidChecksum
        case invalidPersonalIdentificationNumber
    }
    
    enum Month: Int {
        case january = 1
        case february
        case march
        case april
        case may
        case june
        case july
        case august
        case september
        case october
        case november
        case december
    }
    
    enum Sex {
        case male, female
    }
    
    let number: String
    
    let year: Int
    let month: Month
    let day: Int
    
    let personalIdentificationNumber: Int
    
    var birthday: Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month.rawValue
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? nil
    }
    
    var sex: Sex {
        if personalIdentificationNumber % 2 == 0 {
            return .female
        } else {
            return .male
        }
    }
    
    init?(_ number: String) throws {
        if !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: number)) {
            throw ValidationError.invalidCharacters
        }
        
        if number.count < 11 {
            throw ValidationError.numberTooShort(number.count)
        }
        
        if number.count > 11 {
            throw ValidationError.numberTooLong(number.count)
        }
        
        guard let month = Int(number.prefix(4).suffix(2)) else {
            throw ValidationError.invalidMonth(String(number.prefix(4).suffix(2)))
        }
        
        if !PESEL.isValid(month: month) {
            throw ValidationError.invalidMonth(String(month))
        }
        
        guard let day = Int(number.prefix(6).suffix(2)) else {
            throw ValidationError.invalidDay(String(number.prefix(6).suffix(2)))
        }
        
        if day == 0 || day > 31 {
            throw ValidationError.invalidDay(String(day))
        }
        
        let monthsWithMax29Days = [ 2, 22, 42, 62, 82 ]
        
        if monthsWithMax29Days.contains(month) && day > 29 {
            throw ValidationError.invalidDay(String(day))
        }
        
        let monthsWith30Days = [4, 6, 9, 11, 24, 26, 29, 31, 44, 46, 49, 51, 64, 66, 69, 71, 84, 86, 89, 91 ]
        
        if monthsWith30Days.contains(month) && day > 30 {
            throw ValidationError.invalidDay(String(day))
        }
        
        self.day = day
        
        let lastTwoYearDigits = number.prefix(2)
        
        var year = Int(lastTwoYearDigits)!
        
        switch month {
        case 1...12:
            year += 1900
            self.month = Month(rawValue: month)!
        case 21...32:
            year += 2000
            self.month = Month(rawValue: month - 20)!
        case 41...52:
            year += 2100
            self.month = Month(rawValue: month - 40)!
        case 61...72:
            year += 2200
            self.month = Month(rawValue: month - 60)!
        case 81...92:
            year += 1800
            self.month = Month(rawValue: month - 80)!
        default:
            throw ValidationError.invalidMonth(String(month))
        }
        
        self.year = year
        
        if !PESEL.isLeapYear(year) && [ 2, 22, 42, 62, 82 ].contains(month) && day > 28 {
            throw ValidationError.invalidDay(String(day))
        }
        
        if !PESEL.validateChecksum(for: number) {
            throw ValidationError.invalidChecksum
        }
        
        self.number = number
        
        if let personalIdentificationNumber = Int(number.suffix(5).prefix(4)) {
            guard personalIdentificationNumber != 0 else {
                throw ValidationError.invalidPersonalIdentificationNumber
            }
            
            self.personalIdentificationNumber = personalIdentificationNumber
        } else {
            throw ValidationError.invalidPersonalIdentificationNumber
        }
    }
    
    static func isLeapYear(_ year: Int) -> Bool {
        if year % 100 == 0 && year % 400 == 0 {
            return true
        }
        
        if year % 4 == 0 {
            return true
        }
        
        return false
    }
    
    static func validateChecksum(for pesel: String) -> Bool {
        let A = Int(pesel.prefix(1))!
        let B = Int(pesel.prefix(2).suffix(1))!
        let C = Int(pesel.prefix(3).suffix(1))!
        let D = Int(pesel.prefix(4).suffix(1))!
        let E = Int(pesel.prefix(5).suffix(1))!
        let F = Int(pesel.prefix(6).suffix(1))!
        let G = Int(pesel.prefix(7).suffix(1))!
        let H = Int(pesel.prefix(8).suffix(1))!
        let I = Int(pesel.prefix(9).suffix(1))!
        let J = Int(pesel.prefix(10).suffix(1))!
        let checksum = Int(pesel.suffix(1))!
        
        var calculatedChecksumSum = (A * 1) + (B * 3) + (C * 7) + (D * 9)
            calculatedChecksumSum += (E * 1) + (F * 3) + (G * 7) + (H * 9) + (I * 1) + (J * 3)
        
        let modulo = calculatedChecksumSum % 10
        
        if modulo == 0 {
            return checksum == 0
        } else {
            return checksum == (10 - modulo)
        }
    }
    
    static func isValid(month: Int) -> Bool {
        if month == 0
            || (month > 12 && month < 21)
            || (month > 32 && month < 41)
            || (month > 52 && month < 61)
            || (month > 72 && month < 81)
            || month > 92 {
            return false
        }
        
        return true
    }
}
