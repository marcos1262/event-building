import SwiftUI

struct CategoryListView<ViewModel: CategoryListViewModelProtocol>: View {

    @StateObject var viewModel: ViewModel

    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .ready(let stateModel):
                CategoryListReadyView(stateModel: stateModel,
                                      onCategorySelected: { categoryId in
                    viewModel.didSelectCategory(categoryId)
                }, onCheckoutTapped: {
                    viewModel.didTapCheckout()
                })
            case .error(let message):
                ErrorView(message: message) {
                    viewModel.loadData()
                }
            }
        }
        .onViewDidLoad {
            viewModel.loadData()
        }
    }
}

// MARK: - Preview

#Preview {
    CategoryListView(viewModel: CategoryListViewModel(network: NetworkProvider()))
}
