import SwiftUI

struct CustomBackButtonModifier: ViewModifier {

    @Environment(\.presentationMode) var presentationMode

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .font(.headline.weight(.bold))
                        }
                    }
                    .accessibilityIdentifier("BackButton")
                }
            }
    }
}

extension View {
    func customBackButton() -> some View {
        modifier(CustomBackButtonModifier())
    }
}
