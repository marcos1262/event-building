import Combine

protocol CategoryListViewModelProtocol where Self: ObservableObject {
    var state: CategoryListViewModel.State { get }
    var nextDestination: NavigationHost.Destination? { get }

    func didSelectCategory(_ categoryId: Int)
    func didTapCheckout()
    func loadData()
}

protocol CategoryListAdapterProtocol {
    func adapt(from model: [Category]) -> CategoryListStateModel
}
