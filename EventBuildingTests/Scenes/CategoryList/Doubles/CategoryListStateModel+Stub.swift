@testable import EventBuilding

extension CategoryListStateModel {

    static func stub(header: HeaderStateModel = .stub(),
                     categories: [CategoryStateModel] = [.stub()],
                     buttonTitle: String = "Save") -> CategoryListStateModel {
        CategoryListStateModel(header: header, categories: categories, buttonTitle: buttonTitle)
    }
}

extension CategoryStateModel {

    static func stub(id: Int = 1,
                     title: String = "Staff",
                     imageURL: String = "",
                     isSelected: Bool = false,
                     selectedCount: String = "") -> CategoryStateModel {
        CategoryStateModel(id: id, title: title, imageURL: imageURL, isSelected: isSelected, selectedCount: selectedCount)
    }
}
