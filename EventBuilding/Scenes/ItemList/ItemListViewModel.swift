import SwiftUI
import Combine

final class ItemListViewModel: ObservableObject {

    enum State {
        case loading
        case ready(ItemListStateModel)
        case error(message: String)
    }

    @Published var state = State.loading
    @Published var nextDestination: NavigationHost.Destination?

    private var subscriptions = Set<AnyCancellable>()
    private var items = [Item]()

    private var selectedItems: [Item] {
        items.filter { selectedItemIds.contains($0.id) }
    }

    private let network: NetworkProviderProtocol
    private let formatter: FormatterProtocol
    private let category: Category
    private var selectedItemIds: Set<Int>
    private let onItemsSelected: (([Item]) -> Void)?

    init(network: NetworkProviderProtocol,
         formatter: FormatterProtocol = Formatter(),
         category: Category,
         selectedItemIds: Set<Int>,
         onItemsSelected: (([Item]) -> Void)? = nil) {
        self.network = network
        self.formatter = formatter
        self.category = category
        self.selectedItemIds = selectedItemIds
        self.onItemsSelected = onItemsSelected
    }

    private func updateReadyState() {
        let minTotal = selectedItems.reduce(0) { $0 + $1.minBudget }
        let maxTotal = selectedItems.reduce(0) { $0 + $1.maxBudget }
        let formattedTotal = formatter.formatTotal(minTotal: minTotal, maxTotal: maxTotal)
        let header = HeaderStateModel(title: category.title,
                                      subtitle: LocalizedStrings.CategoryList.Header.subtitle,
                                      total: formattedTotal)
        let items = items.map {
            let formattedBudget = formatter.formatTotal(minTotal: $0.minBudget, maxTotal: $0.maxBudget)
            return ItemStateModel(id: $0.id,
                                  title: $0.title,
                                  budget: formattedBudget,
                                  imageURL: $0.image,
                                  isSelected: selectedItemIds.contains($0.id))
        }
        state = .ready(ItemListStateModel(header: header, items: items))
    }

    func didSelectItem(_ itemId: Int) {
        if selectedItemIds.contains(itemId) {
            selectedItemIds.remove(itemId)
        } else {
            selectedItemIds.insert(itemId)
        }
        onItemsSelected?(selectedItems)
        updateReadyState()
    }

    func loadData() {
        network.fetch(ItemsRequest(id: category.id))
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
                self?.items = response
                self?.updateReadyState()
            }
            .store(in: &subscriptions)
    }
}
