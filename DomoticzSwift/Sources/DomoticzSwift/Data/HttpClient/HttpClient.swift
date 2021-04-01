//
//  HttpClient.swift
//  
//
//  Created by Michał Solski on 31/03/2021.
//

import Foundation
import Combine

//sourcery: AutoMockable
protocol HttpClient {
   func call(request: HttpRequest) -> AnyPublisher<HttpResponse, Error>
}

class HttpClientImpl: HttpClient {
    func call(request: HttpRequest) -> AnyPublisher<HttpResponse, Error> {
        let urlRequest = createURLRequest(httpRequest: request)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { (data, urlResponse) -> HttpResponse in
                let responseHeaders = (urlResponse as? HTTPURLResponse)?.responseHeaders()
                return HttpResponse(data: data, responseHeaders: responseHeaders ?? [:])
            }.mapError { (urlError) -> Error in
                return urlError
        }.eraseToAnyPublisher()
    }

    private func createURLRequest(httpRequest: HttpRequest) -> URLRequest {
        var request: URLRequest

        switch httpRequest.method {
        case .get:
            let urlComponents = NSURLComponents(url: httpRequest.url, resolvingAgainstBaseURL: false)
            addQueryItems(components: urlComponents!, paramsToAdd: httpRequest.params)
            request = URLRequest(url: urlComponents!.url!, cachePolicy:
                                    .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
            request.httpMethod = "GET"
        case .post:
            request = URLRequest(url: httpRequest.url as URL, cachePolicy:
                                    .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
            request.httpMethod = "POST"
            request.httpBody = try! JSONSerialization.data(withJSONObject: httpRequest.params, options: [])
        }
        httpRequest.headers.forEach { request.setValue($0.1, forHTTPHeaderField: $0.0) }
        return request
    }

    private func addQueryItems(components: NSURLComponents, paramsToAdd: [String: String]) {
        if components.queryItems != nil {
            components.queryItems!.append(contentsOf: queryItemsFrom(dictionary: paramsToAdd))
            return
        }
        components.queryItems = queryItemsFrom(dictionary: paramsToAdd)
    }

    func queryItemsFrom(dictionary: [String: String]) -> [URLQueryItem] {
        var items: [URLQueryItem] = []
        for key in dictionary.keys {
            let query = URLQueryItem(name: key, value: dictionary[key])
            items.append(query)
        }
        return items
    }
}

private extension HTTPURLResponse {
    func responseHeaders() -> HttpHeaders {
        return self.allHeaderFields
            .filter({ $0 is HttpHeaderKey && $1 is HttpHeaderValue })
            .map({ ($0 as! HttpHeaderKey, $1 as! HttpHeaderValue) })
            .reduce([:], { (result, next) -> [HttpHeaderKey: HttpHeaderValue] in
                var result = result
                result[next.0] = next.1
                return result
            })
    }
}
