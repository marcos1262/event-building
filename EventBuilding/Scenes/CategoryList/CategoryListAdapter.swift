struct CategoryListAdapter {

    private let formatter: FormatterProtocol

    init(formatter: FormatterProtocol = Formatter()) {
        self.formatter = formatter
    }

    private func adaptTotal(from model: [Category]) -> String {
        let selectedItems = Set(model.map { $0.selectedItems }.joined())
        let minTotal = selectedItems.reduce(0) { $0 + $1.minBudget }
        let maxTotal = selectedItems.reduce(0) { $0 + $1.maxBudget }
        return formatter.formatTotal(minTotal: minTotal, maxTotal: maxTotal)
    }
}

// MARK: - CategoryListAdapterProtocol

extension CategoryListAdapter: CategoryListAdapterProtocol {

    func adapt(from model: [Category]) -> CategoryListStateModel {
        let header = HeaderStateModel(title: LocalizedStrings.CategoryList.Header.title,
                                      subtitle: LocalizedStrings.CategoryList.Header.subtitle,
                                      total: adaptTotal(from: model))
        let categories = model.map { CategoryStateModel(id: $0.id,
                                                             title: $0.title,
                                                             imageURL: $0.image,
                                                             isSelected: !$0.selectedItems.isEmpty,
                                                             selectedCount: formatter.formatPadding($0.selectedItems.count)) }
        return CategoryListStateModel(header: header,
                                      categories: categories,
                                      buttonTitle: LocalizedStrings.CategoryList.buttonTitle)
    }
}
