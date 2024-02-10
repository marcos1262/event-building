struct CategoryStateModel: Identifiable, Equatable {
    let id: Int
    let title: String
    let imageURL: String
    let isSelected: Bool
    let selectedCount: String
}
