import SwiftUI

struct ErrorView: View {

    private let message: String
    private let onRetryTapped: (() -> Void)?

    init(message: String,
         onRetryTapped: (() -> Void)? = nil) {
        self.message = message
        self.onRetryTapped = onRetryTapped
    }

    var body: some View {
        VStack {
            Text(message)
            Button(LocalizedStrings.Error.retry) {
                onRetryTapped?()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ErrorView(message: "Some error ocurred...")
}
