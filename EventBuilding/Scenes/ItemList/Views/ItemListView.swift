import SwiftUI

struct ItemListView: View {

    @StateObject var viewModel: ItemListViewModel

    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .ready(let itemList):
                ItemListReadyView(stateModel: itemList) { itemId in
                    viewModel.didSelectItem(itemId)
                }
            case .error(let message):
                ErrorView(message: message)
            }
        }
        .customBackButton()
        .onAppear {
            viewModel.loadData()
        }
    }
}

// MARK: - Preview

#Preview {
    ItemListView(viewModel: ItemListViewModel(network: NetworkProvider(),
                                              category: Category(id: 1,
                                                                 title: "Staff",
                                                                 image: ""),
                                              selectedItemIds: Set([1])))
}
