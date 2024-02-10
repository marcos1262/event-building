import Foundation

enum LocalizedStrings {
    static let empty = localized("empty")

    enum CategoryList {
        enum Header {
            static let title = localized("CategoryList.Header.title")
            static let subtitle = localized("CategoryList.Header.subtitle")
        }

        static let buttonTitle = localized("CategoryList.buttonTitle")
    }

    enum Error {
        static let retry = localized("Error.retry")
    }

    enum Checkout {
        static let title = localized("Checkout.title")
    }
}

extension LocalizedStrings {
    private static func localized(_ title: String) -> String {
        NSLocalizedString(title, comment: "")
    }
}
