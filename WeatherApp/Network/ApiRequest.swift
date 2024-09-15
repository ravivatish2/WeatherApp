//
//  ApiRequest.swift
//  WeatherApp
//
//  Created by ravinder kumar on 9/13/24.
//


import Foundation

/// This enum will contain all the api endpoints used by ConnectionManager
enum ApiEndPoint: String {
    case getCities = "/geo/1.0/direct"
    case latLongWeather = "/data/2.5/weather"
    case image = "/img/wn/"
    
    
    private var baseURL : String {
        return "https://api.openweathermap.org"
    }
    var completeURL: String {
        baseURL + self.rawValue
    }
}

/// Rest api methods list
enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct EmptyBody: Codable {}

enum Parameters {
    case iconName(String)
    case list([String: String])
}

/// Api request builder
struct ApiRequest<T: Encodable > {
    private let api: ApiEndPoint
    private let httpMethod: HttpMethod
    private var headers: [String: String]?
    private let data: T?
    private var params: [String: String] = [:]
    private var completeURL: URL {
        var url = api.completeURL
        if (!params.isEmpty) {
            url += "?"
            url += convertParams!
        }
        url = url.replacingOccurrences(of:" ", with: "%20")
        return URL(string: url)!
    }
    
    private var convertParams: String? {
        var _convertParams: String = ""
        for (key, value) in params {
            if (!_convertParams.isEmpty) {
                _convertParams += "&"
            }
            _convertParams += key
            _convertParams += "="
            _convertParams += value
        }
        //Add Api Key
        _convertParams += "&appid=4e9ee6a7ae5b4106e483e61222946c1c"
        return _convertParams
    }
    
    var request: URLRequest {
        var request = URLRequest(url: completeURL)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        if( data is EmptyBody == false ) {
            request.httpBody = try! JSONEncoder().encode(data)
        }
        print("Rest request :\(#file) \(#line) :: request")
        return request
    }
    
    /// Create and initialize APi Request for ConnectionManager
    ///
    /// - Parameter api: Define new api endpoint in the enum `ApiEndPoint`  first to use here
    /// - Parameter data : It's a Encodable Data Model that we use to construct our api. eg : `RefreshTokenRequest`
    /// - Parameter httpMethod: default is set to .post, but you can choose from the enum `HttpMethod`
    /// - Parameter headers: we are adding some default headers, like content-type and authorization token. Also,
    /// if you want to just add another field in this header use `overrideHeader` instead.
    /// Add new endponits in `BaseURL` enum to modify this field
    /// - Parameter params: This field is useful in case of `REST GET` call, when you want to embed data to the URL
    ///
    init(api: ApiEndPoint, data: T? = EmptyBody(), httpMethod: HttpMethod = .get, headers: [String: String]? =  ApiRequest.defaultHeaders(), params: [String: String] = [:]) {
        self.api = api
        self.httpMethod = httpMethod
        self.headers = headers
        self.data = data
        self.params = params
    }
    private static func defaultHeaders() -> [String: String]? {
        var headers: [String: String]? = [:]
      //  headers?["Content-Type"] = "application/json"
       // headers?["Authorization"] = "Basic SW50ZWxpdHk6alNQTnpANDJaKGYrb0ArbTFsQXgoSEd5Z2ZRVDI="
        return headers
    }
    
    /// method to update dault headers
    mutating func overrideHeader(headerField: String, headerValue: String) {
        if (headers != nil) {
            headers?[headerField] = headerValue
        } else {
            headers?.updateValue(headerValue, forKey: headerField)
        }
    }
}
