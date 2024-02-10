import CleanNetwork

struct CategoriesRequest: CLNetworkDecodableRequest {
    typealias ResponseType = [Category]

    let endpoint = CLEndpoint(baseURL: "swensonhe-dev-challenge.s3.us-west-2.amazonaws.com",
                              path: "categories.json")
    let method = CLHTTPMethod.get
}
