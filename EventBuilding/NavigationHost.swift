import SwiftUI
import Combine

struct NavigationHost: View {

    enum Destination {
        case itemList(category: Category,
                      selectedItemIds: Set<Int>,
                      onItemsSelected: (([Item]) -> Void)?)
        case checkout(total: String)
    }

    @State private var destination: Destination?

    private let network: NetworkProviderProtocol

    init(network: NetworkProviderProtocol) {
        self.network = network
    }

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: buildChildViewFromState(),
                    isActive: $destination.isNilBinding(),
                    label: {
                        EmptyView()
                    }
                )
                CategoryListView(viewModel: buildInitialViewModel())
            }
        }
    }

    private func buildInitialViewModel() -> CategoryListViewModel {
        CategoryListViewModel(network: network) { category, selectedItemIds, onItemsSelected in
            destination = .itemList(category: category,
                                    selectedItemIds: selectedItemIds,
                                    onItemsSelected: onItemsSelected)
        } onCheckoutTapped: { total in
            destination = .checkout(total: total)
        }
    }

    @ViewBuilder
    private func buildChildViewFromState() -> some View {
        switch destination {
        case .itemList(let category, let selectedItemIds, let onItemsSelected):
            ItemListView(viewModel: ItemListViewModel(network: network,
                                                      category: category,
                                                      selectedItemIds: selectedItemIds,
                                                      onItemsSelected: onItemsSelected))
        case .checkout(let total):
            CheckoutView(total: total)
        case .none:
            EmptyView()
        }
    }
}
