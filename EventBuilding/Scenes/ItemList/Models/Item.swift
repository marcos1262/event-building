struct Item: Decodable, Equatable {
    let id: Int
    let title: String
    let minBudget: Int
    let maxBudget: Int
    let avgBudget: Int
    let image: String
}

extension Item: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
