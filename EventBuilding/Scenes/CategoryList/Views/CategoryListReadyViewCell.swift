import SwiftUI
import Kingfisher

struct CategoryListReadyViewCell: View {

    private let stateModel: CategoryStateModel

    init(stateModel: CategoryStateModel) {
        self.stateModel = stateModel
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                KFImage(URL(string: stateModel.imageURL))
                    .placeholder {
                        ProgressView()
                            .frame(maxHeight: 10)
                    }
                    .resizable()
                    .scaledToFit()

                HStack {
                    Text(stateModel.title)
                        .font(.small)
                        .foregroundColor(.text)
                        .accessibilityIdentifier("CategoryTitle")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.headline.bold())
                        .foregroundColor(.accentColor)
                }
                .padding(.small)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(stateModel.isSelected ? .accent : .stroke,
                            lineWidth: stateModel.isSelected ? 2 : 1)
            )

            if stateModel.isSelected {
                ZStack {
                    Image(systemName: "circle.fill")
                        .foregroundColor(.accentColor)
                        .font(.title2)

                    Image(systemName: "circle")
                        .foregroundColor(.white.opacity(0.2))
                        .font(.title2)

                    Text(stateModel.selectedCount)
                        .font(.small)
                        .foregroundColor(.white)
                }
                .padding(.xSmall)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    VStack {
        CategoryListReadyViewCell(stateModel: CategoryStateModel(id: 1,
                                                                 title: "Staff",
                                                                 imageURL: "https://swensonhe-dev-challenge.s3.us-west-2.amazonaws.com/staff.png",
                                                                 isSelected: false,
                                                                 selectedCount: ""))
        .frame(width: 150, height: 150)

        CategoryListReadyViewCell(stateModel: CategoryStateModel(id: 1,
                                                                 title: "Staff",
                                                                 imageURL: "https://swensonhe-dev-challenge.s3.us-west-2.amazonaws.com/staff.png",
                                                                 isSelected: true,
                                                                 selectedCount: "03"))
        .frame(width: 150, height: 150)
    }
}
