import Foundation
import Combine
import CleanNetwork

final class NetworkProvider {

    private var network = CLNetworkService.shared

    var config: NetworkConfig {
        get {
            network.config
        }
        set {
            network.config = newValue
        }
    }

    init() {
        network.config.loggerEnabled = false
    }
}

extension NetworkProvider: NetworkProviderProtocol {

    func fetch<T: CLNetworkBodyRequest>(_ request: T) -> AnyPublisher<T.ResponseType, CLError> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(.errorMessage(.statusCodeIsNotValid)))
                return
            }
            Task {
                do {
                    promise(.success(try await self.network.fetch(request)))
                } catch let error as CLError {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    func fetch<T: CLNetworkDecodableRequest>(_ request: T) -> AnyPublisher<T.ResponseType, CLError> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(.errorMessage(.statusCodeIsNotValid)))
                return
            }
            Task {
                do {
                    promise(.success(try await self.network.fetch(request)))
                } catch let error as CLError {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    func fetch<T: CLNetworkRequest>(_ request: T) -> AnyPublisher<Data, CLError> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(.errorMessage(.statusCodeIsNotValid)))
                return
            }
            Task {
                do {
                    promise(.success(try await self.network.fetch(request)))
                } catch let error as CLError {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
