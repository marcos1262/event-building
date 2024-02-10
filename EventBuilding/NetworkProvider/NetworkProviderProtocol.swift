import Foundation
import Combine
import CleanNetwork

protocol NetworkProviderProtocol {
    var config: NetworkConfig { get set }

    func fetch<T: CLNetworkBodyRequest>(_ request: T) -> AnyPublisher<T.ResponseType, CLError>
    func fetch<T: CLNetworkDecodableRequest>(_ request: T) -> AnyPublisher<T.ResponseType, CLError>
    func fetch<T: CLNetworkRequest>(_ request: T) -> AnyPublisher<Data, CLError>
}
