@testable import EventBuilding

final class CategoryListAdapterSpy: CategoryListAdapterProtocol {

    private(set) var adaptParameters = [[Category]]()

    func adapt(from model: [Category]) -> CategoryListStateModel {
        adaptParameters.append(model)
        return .stub()
    }
}
