import SwiftUI

struct HeaderView: View {

    var stateModel: HeaderStateModel

    var body: some View {
        VStack(spacing: .medium) {
            Text(stateModel.title)
                .font(.largeBlack)
            Text(stateModel.subtitle)
                .font(.medium)
                .foregroundColor(.text)
            Text(stateModel.total)
                .font(.hugeBlack)
        }
    }
}

// MARK: - Preview

#Preview {
    VStack {
        HeaderView(stateModel: HeaderStateModel(title: "Event Builder",
                                                subtitle: "Add to your event to view our cost estimate.",
                                                total: "-"))

        HeaderView(stateModel: HeaderStateModel(title: "Event Builder",
                                                subtitle: "Add to your event to view our cost estimate.",
                                                total: "$1,234-5,678"))
    }
}
