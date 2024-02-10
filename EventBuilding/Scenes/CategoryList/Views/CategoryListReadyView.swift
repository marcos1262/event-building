import SwiftUI

struct CategoryListReadyView: View {

    private let gridItems = [GridItem(spacing: .medium), GridItem()]
    private let stateModel: CategoryListStateModel
    private let onCategorySelected: ((_ categoryId: Int) -> Void)?
    private let onCheckoutTapped: (() -> Void)?

    init(stateModel: CategoryListStateModel,
         onCategorySelected: ((_ categoryId: Int) -> Void)? = nil,
         onCheckoutTapped: (() -> Void)? = nil) {
        self.stateModel = stateModel
        self.onCategorySelected = onCategorySelected
        self.onCheckoutTapped = onCheckoutTapped
    }

    var body: some View {
        VStack(spacing: .medium) {
            HeaderView(stateModel: stateModel.header)

            ScrollView {
                LazyVGrid(columns: gridItems, spacing: .medium) {
                    ForEach(stateModel.categories) { category in
                        CategoryListReadyViewCell(stateModel: category)
                            .onTapGesture {
                                onCategorySelected?(category.id)
                            }
                    }
                }
            }

            Button(action: {
                onCheckoutTapped?()
            }) {
                Text(stateModel.buttonTitle)
                    .padding()
                    .font(.mediumBlack)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            .accessibilityIdentifier("SaveButton")
        }
        .padding(EdgeInsets(top: .huge, leading: .medium, bottom: .huge, trailing: .medium))
    }
}

// MARK: - Preview

#Preview {
    CategoryListReadyView(stateModel: CategoryListStateModel(header: HeaderStateModel(title: "Event Builder",
                                                                                      subtitle: "Add to your event to view our cost estimate.",
                                                                                      total: "-"),
                                                             categories: [
                                                                CategoryStateModel(id: 1,
                                                                                   title: "Staff",
                                                                                   imageURL: "https://swensonhe-dev-challenge.s3.us-west-2.amazonaws.com/staff.png",
                                                                                   isSelected: false,
                                                                                   selectedCount: ""),
                                                                CategoryStateModel(id: 2,
                                                                                   title: "Staff",
                                                                                   imageURL: "https://swensonhe-dev-challenge.s3.us-west-2.amazonaws.com/staff.png",
                                                                                   isSelected: false,
                                                                                   selectedCount: ""),
                                                                CategoryStateModel(id: 3,
                                                                                   title: "Staff",
                                                                                   imageURL: "https://swensonhe-dev-challenge.s3.us-west-2.amazonaws.com/staff.png",
                                                                                   isSelected: true,
                                                                                   selectedCount: "02")
                                                             ],
                                                             buttonTitle: "Save"))
}
