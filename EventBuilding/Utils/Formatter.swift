import Foundation

protocol FormatterProtocol {
    func formatTotal(minTotal: Int, maxTotal: Int) -> String
    func formatPadding(_ number: Int) -> String
}

struct Formatter: FormatterProtocol {

    func formatTotal(minTotal: Int, maxTotal: Int) -> String {
        if maxTotal == 0 {
            return "-"
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        let formattedMinTotal = formatter.string(from: minTotal as NSNumber) ?? "-"
        if minTotal == maxTotal {
            return formattedMinTotal
        }

        formatter.currencySymbol = ""
        let formattedMaxTotal = formatter.string(from: maxTotal as NSNumber) ?? "-"
        return "\(formattedMinTotal)-\(formattedMaxTotal)"
    }

    func formatPadding(_ number: Int) -> String {
        String(format: "%02d", number)
    }
}
