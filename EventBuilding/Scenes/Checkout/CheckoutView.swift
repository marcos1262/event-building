import SwiftUI

struct CheckoutView: View {

    private var total: String

    init(total: String) {
        self.total = total
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)

            VStack(spacing: .medium) {
                Text(LocalizedStrings.Checkout.title)
                    .font(.largeBlack)
                Text(total)
                    .font(.hugeBlack)
                Image(systemName: "star.fill")
                    .font(.largeTitle)
            }
        }
        .padding(.large)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundPrimary)
        .ignoresSafeArea()
        .customBackButton()
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        NavigationLink(destination: CheckoutView(total: "$23,250-24,050"),
                       isActive: Binding(get: { true }, set: { _ in }),
                       label: { EmptyView() })
        EmptyView()
    }
}
