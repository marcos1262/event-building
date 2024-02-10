import SwiftUI
import Combine

final class CategoryListViewModel: ObservableObject {

    enum State: Equatable {
        case loading
        case ready(CategoryListStateModel)
        case error(message: String)
    }

    @Published var state = State.loading
    @Published var nextDestination: NavigationHost.Destination?

    private var categories = [Category]()
    private var subscriptions = Set<AnyCancellable>()

    private var selectedItems: Set<Item> {
        Set(categories.map { $0.selectedItems }.joined())
    }

    private let network: NetworkProviderProtocol
    private let adapter: CategoryListAdapterProtocol
    private let formatter: FormatterProtocol
    private let onCategorySelected: ((_ category: Category,
                                      _ selectedItemIds: Set<Int>,
                                      _ onItemsSelected: (([Item]) -> Void)?) -> Void)?
    private let onCheckoutTapped: ((_ total: String) -> Void)?

    init(network: NetworkProviderProtocol,
         adapter: CategoryListAdapterProtocol = CategoryListAdapter(),
         formatter: FormatterProtocol = Formatter(),
         onCategorySelected: ((_ category: Category,
                               _ selectedItemIds: Set<Int>,
                               _ onItemsSelected: (([Item]) -> Void)?) -> Void)? = nil,
         onCheckoutTapped: ((_ total: String) -> Void)? = nil) {
        self.network = network
        self.adapter = adapter
        self.formatter = formatter
        self.onCategorySelected = onCategorySelected
        self.onCheckoutTapped = onCheckoutTapped
    }

    private func updateReadyState() {
        state = .ready(adapter.adapt(from: categories))
    }
}

// MARK: - CategoryListViewModelProtocol

extension CategoryListViewModel: CategoryListViewModelProtocol {

    func didSelectCategory(_ categoryId: Int) {
        guard let index = categories.firstIndex(where: { $0.id == categoryId }) else { return }

        let selectedItemIds = Set(selectedItems.map { $0.id })

        onCategorySelected?(categories[index], selectedItemIds) { [weak self] selectedItems in
            self?.categories[index].selectedItems = selectedItems
            self?.updateReadyState()
        }
    }

    func didTapCheckout() {
        let minTotal = selectedItems.reduce(0) { $0 + $1.minBudget }
        let maxTotal = selectedItems.reduce(0) { $0 + $1.maxBudget }
        let formattedTotal = formatter.formatTotal(minTotal: minTotal, maxTotal: maxTotal)

        onCheckoutTapped?(formattedTotal)
    }

    func loadData() {
        network.fetch(CategoriesRequest())
            .retry(2)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.state = .loading
            })
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.state = .error(message: error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                self?.categories = response
                self?.updateReadyState()
            }
            .store(in: &subscriptions)
    }
}
