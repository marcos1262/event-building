@testable import EventBuilding

final class FormatterSpy: FormatterProtocol {

    private(set) var formatTotalParameters = [(minTotal: Int, maxTotal: Int)]()
    private(set) var formatPaddingParameters = [Int]()

    func formatTotal(minTotal: Int, maxTotal: Int) -> String {
        formatTotalParameters.append((minTotal, maxTotal))
        return "$1,234-5,678"
    }

    func formatPadding(_ number: Int) -> String {
        formatPaddingParameters.append(number)
        return "03"
    }
}
