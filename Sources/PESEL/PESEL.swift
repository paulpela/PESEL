import Foundation

struct PESEL {
    enum ValidationError: Error {
        case invalidNumber
        case numberTooShort(Int)
        case numberTooLong(Int)
        case invalidCharacters
        case invalidMonth(String)
        case invalidDay(String)
        case invalidChecksum
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
        
        let month = number.prefix(4).suffix(2)
        
        if month == "00"
            || (Int(month)! > 12 && Int(month)! < 21)
            || (Int(month)! > 32 && Int(month)! < 41)
            || (Int(month)! > 52 && Int(month)! < 61)
            || (Int(month)! > 72 && Int(month)! < 81)
            || Int(month)! > 92 {
            throw ValidationError.invalidMonth(String(month))
        }
        
        let day = number.prefix(6).suffix(2)
        
        if day == "00" || Int(day)! > 31 {
            throw ValidationError.invalidDay(String(day))
        }
        
        let monthsWithMax29Days = [ 2, 22, 42, 62, 82 ]
        
        if monthsWithMax29Days.contains(Int(month)!) && Int(day)! > 29 {
            throw ValidationError.invalidDay(String(day))
        }
        
        let monthsWith30Days = [4, 6, 9, 11, 24, 26, 29, 31, 44, 46, 49, 51, 64, 66, 69, 71, 84, 86, 89, 91 ]
        
        if monthsWith30Days.contains(Int(month)!) && Int(day)! > 30 {
            throw ValidationError.invalidDay(String(day))
        }
        
        let lastTwoYearDigits = number.prefix(2)
        
        var year = Int(lastTwoYearDigits)!
        let monthInt = Int(month)!
        
        switch monthInt {
        case 1...12:
            year += 1900
        case 21...32:
            year += 2000
        case 41...52:
            year += 2100
        case 61...72:
            year += 2200
        case 81...92:
            year += 1800
        default:
            throw ValidationError.invalidMonth(String(month))
        }
        
        if !PESEL.isLeapYear(year) && [ 2, 22, 42, 62, 82 ].contains(monthInt) && Int(day)! > 28 {
            throw ValidationError.invalidDay(String(day))
        }
        
        if !PESEL.validateChecksum(for: number) {
            throw ValidationError.invalidChecksum
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
}
