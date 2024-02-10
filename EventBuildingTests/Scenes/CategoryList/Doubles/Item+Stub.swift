@testable import EventBuilding

extension Item {

    static func stub(id: Int = 1,
                     title: String = "Waiter Staff",
                     minBudget: Int = 1,
                     maxBudget: Int = 3,
                     avgBudget: Int = 2,
                     image: String = "") -> Item {
        Item(id: id, title: title, minBudget: minBudget, maxBudget: maxBudget, avgBudget: avgBudget, image: image)
    }
}
