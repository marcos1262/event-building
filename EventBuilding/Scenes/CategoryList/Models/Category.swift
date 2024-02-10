struct Category: Decodable, Equatable {
    let id: Int
    let title: String
    let image: String

    var selectedItems = [Item]()

    enum CodingKeys: String, CodingKey {
        case id, title, image
    }
}
