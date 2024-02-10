import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad = false

    let action: (() -> Void)?

    func body(content: Content) -> some View {
        content.onAppear {
            if !viewDidLoad {
                viewDidLoad = true
                action?()
            }
        }
    }
}

extension View {
    func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(action: action))
    }
}
