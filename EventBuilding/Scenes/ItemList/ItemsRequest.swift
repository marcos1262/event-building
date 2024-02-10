import CleanNetwork

struct ItemsRequest: CLNetworkDecodableRequest {
    typealias ResponseType = [Item]

    let endpoint: CLEndpoint
    let method = CLHTTPMethod.get

    init(id: Int) {
        self.endpoint = CLEndpoint(baseURL: "swensonhe-dev-challenge.s3.us-west-2.amazonaws.com",
                                   path: "categories/\(id).json")
    }
}
