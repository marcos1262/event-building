import CleanNetwork
import Combine
import Foundation

@testable import EventBuilding

final class NetworkProviderMock: NetworkProviderProtocol {

    var config: NetworkConfig = CLNetworkConfig()

    var stubResult: Result<Decodable, CLError> = .failure(.errorMessage(.statusCodeIsNotValid))

    private(set) var fetchParameters = [any CLNetworkDecodableRequest]()

    func fetch<T: CLNetworkBodyRequest>(_ request: T) -> AnyPublisher<T.ResponseType, CLError> {
        return Future { $0(.failure(.errorMessage(.statusCodeIsNotValid))) }.eraseToAnyPublisher()
    }

    func fetch<T: CLNetworkDecodableRequest>(_ request: T) -> AnyPublisher<T.ResponseType, CLError> {
        fetchParameters.append(request)
        return stubResult.publisher
            .map { $0 as! T.ResponseType }
            .eraseToAnyPublisher()
    }

    func fetch<T: CLNetworkRequest>(_ request: T) -> AnyPublisher<Data, CLError> {
        return Future { $0(.failure(.errorMessage(.statusCodeIsNotValid))) }.eraseToAnyPublisher()
    }
}
