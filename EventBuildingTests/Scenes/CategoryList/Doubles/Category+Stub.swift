@testable import EventBuilding

extension Category {

    static func stub(id: Int = 1,
                     title: String = "Staff",
                     image: String = "",
                     selectedItems: [Item] = []) -> Category {
        Category(id: id, title: title, image: image, selectedItems: selectedItems)
    }
}
