import SwiftUI
import Kingfisher

struct ItemListReadyViewCell: View {

    private let stateModel: ItemStateModel
    private let onItemSelected: ((_ itemId: Int) -> Void)?

    init(stateModel: ItemStateModel,
         onItemSelected: ((_ itemId: Int) -> Void)? = nil) {
        self.stateModel = stateModel
        self.onItemSelected = onItemSelected
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: .zero) {
                KFImage(URL(string: stateModel.imageURL))
                    .placeholder {
                        ProgressView()
                            .frame(maxHeight: 100)
                    }
                    .resizable()
                    .scaledToFit()

                VStack(alignment: .leading, spacing: .zero) {
                    Text(stateModel.title)
                        .font(.small)
                        .foregroundColor(.text)
                    Text(stateModel.budget)
                        .font(.smallHeavy)
                }
                .padding(EdgeInsets(top: .xSmall, leading: .small, bottom: .xSmall, trailing: .small))
            }
            .overlay(RoundedRectangle(cornerRadius: 5)
                .stroke(.stroke, lineWidth: 1))

            ZStack {
                Image(systemName: "circle.fill")
                    .foregroundColor(stateModel.isSelected ? .black : .black.opacity(0.2))
                    .font(.title2)

                if stateModel.isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .font(.caption.weight(.black))
                } else {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.caption.weight(.black))
                        .accessibilityIdentifier("ItemAddAction")
                }
            }
            .padding(.xSmall)
            .onTapGesture {
                onItemSelected?(stateModel.id)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    VStack {
        ItemListReadyViewCell(stateModel: ItemStateModel(id: 1,
                                                         title: "Staff",
                                                         budget: "$1,234-5,678",
                                                         imageURL: "ahttps://swensonhe-dev-challenge.s3.us-west-2.amazonaws.com/staff.png",
                                                         isSelected: false))
        .frame(width: 150, height: 150)

        ItemListReadyViewCell(stateModel: ItemStateModel(id: 1,
                                                         title: "Staff",
                                                         budget: "$1,234-5,678",
                                                         imageURL: "https://swensonhe-dev-challenge.s3.us-west-2.amazonaws.com/staff.png",
                                                         isSelected: true))
        .frame(width: 150, height: 150)
    }
}
