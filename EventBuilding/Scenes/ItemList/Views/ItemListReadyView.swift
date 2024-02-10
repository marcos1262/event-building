import SwiftUI

struct ItemListReadyView: View {

    private let stateModel: ItemListStateModel
    private let gridItem = [GridItem(spacing: .medium), GridItem()]
    private let onItemSelected: ((_ itemId: Int) -> Void)?

    init(stateModel: ItemListStateModel,
         onItemSelected: ((_ itemId: Int) -> Void)? = nil) {
        self.stateModel = stateModel
        self.onItemSelected = onItemSelected
    }

    var body: some View {
        VStack(spacing: .medium) {
            HeaderView(stateModel: stateModel.header)

            ScrollView {
                LazyVGrid(columns: gridItem, spacing: .medium) {
                    ForEach(stateModel.items) { item in
                        ItemListReadyViewCell(stateModel: item, onItemSelected: onItemSelected)
                    }
                }
            }
        }
        .padding(EdgeInsets(top: .huge,
                            leading: .medium,
                            bottom: .zero,
                            trailing: .medium))
    }
}

// MARK: - Preview

#Preview {
    ItemListReadyView(stateModel: ItemListStateModel(header: HeaderStateModel(title: "Event Builder",
                                                                              subtitle: "Add to your event to view our cost estimate.",
                                                                              total: "-"),
                                                     items: [
                                                        ItemStateModel(id: 1,
                                                                       title: "Staff",
                                                                       budget: "$1,234-5,678",
                                                                       imageURL: "https://swensonhe-dev-challenge.s3.us-west-2.amazonaws.com/staff.png",
                                                                       isSelected: true),
                                                        ItemStateModel(id: 2,
                                                                       title: "Staff",
                                                                       budget: "$1,234-5,678",
                                                                       imageURL: "https://swensonhe-dev-challenge.s3.us-west-2.amazonaws.com/staff.png",
                                                                       isSelected: false),
                                                        ItemStateModel(id: 3,
                                                                       title: "Staff",
                                                                       budget: "$1,234-5,678",
                                                                       imageURL: "https://swensonhe-dev-challenge.s3.us-west-2.amazonaws.com/staff.png",
                                                                       isSelected: false)
                                                     ]))
}
