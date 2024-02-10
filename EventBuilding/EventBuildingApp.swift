import SwiftUI

@main
struct EventBuildingApp: App {

    private let network: NetworkProviderProtocol = NetworkProvider()

    var body: some Scene {
        WindowGroup {
            NavigationHost(network: network)
                .background(Color.backgroundPrimary)
        }
    }
}
