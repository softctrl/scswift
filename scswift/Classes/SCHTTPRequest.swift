//
//  SCHTTPRequest.swift
//  SCSwift
//
//  Created by Timoshenko on 28/03/17.
//  Copyright © 2017 softctrl.com.br. All rights reserved.
//

import Foundation

/// Basic HTTP restful client.
open class SCHTTPRequest: NSObject {
    
    /// Supported HTTP methods.
    public final class HTTPMethod {
        public static var GET = "GET"
        public static var POST = "POST"
        public static var DELETE = "DELETE"
        public static var PUT = "PUT"
        public static var PATCH = "PATCH"
        public static var OPTIONS = "OPTIONS"
    }
    
    
    /// HTTP Content Types.
    public final class ContentType {
        static var FIELD_NAME = "Content-Type"
        public static var JSON = "application/json"
        public static var STREAM = "application/octet-stream"
        public static var URL_ENCODED = "application/x-www-form-urlencoded"
        public static var XML = "application/xml"
        public static var JPEG = "image/jpeg"
        public static var PNG = "image/png"
        public static var GIF = "image/gif"
        public static var FORM_DATA = "multipart/form-data"
        public static var TEXT = "text/plain"
    }

    /// Default Initializer
    public override init() {

        super.init()
        
    }
    
    /// Create a valid NSMutableURLRequest.
    ///
    /// - Parameter method: a valid HTTP verb.
    /// - Returns: a valid NSMutableURLRequest.
    open func createUrlRequest(_ method : String! = HTTPMethod.GET, _ url: URL!) -> NSMutableURLRequest {
        
        let urlRequest : NSMutableURLRequest = NSMutableURLRequest(url: url)
        urlRequest.httpMethod = method
        return urlRequest
        
    }

    /// Perform a HTTP verb on the specified url.
    ///
    /// - Parameters:
    ///   - method: HTTP Verb.
    ///   - url: url address.
    ///   - completionHandler: A closure that will handle the performed request.
    private func perform(method: String, url : String, body : String? = nil, completionHandler : @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        
        let urlRequest : NSMutableURLRequest = self.createUrlRequest(method, URL(string: url)!)
        urlRequest.httpMethod = method

        urlRequest.httpBody = body?.data(using: String.Encoding.ascii)
        
        urlRequest.addValue(ContentType.JSON, forHTTPHeaderField : ContentType.FIELD_NAME) // TODO: make this configurable.
        
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest, completionHandler: completionHandler)

        task.resume()

    }
    
    /// Performs a valid GET into a valid informed URL.
    ///
    /// - Parameters:
    ///   - url: a valid String URL.
    ///   - completionHandler: a valid handler for the request.
    public func get(url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {

        print("URL: \(url)")
        self.perform(method: HTTPMethod.GET, url : url, completionHandler : completionHandler)

    }
    
    /// Performs a valid POST into a valid informed URL.
    ///
    /// - Parameters:
    ///   - url: a valid String URL.
    ///   - body: a String Body.
    ///   - completionHandler: a valid handler for the request.
    public func post(url: String, body: String? = nil, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        print("\(body ?? "")\n")
        self.perform(method: HTTPMethod.POST, url : url, body: body, completionHandler : completionHandler)
        
    }
    
    /// Performs a valid DELETE into a valid informed URL.
    ///
    /// - Parameters:
    ///   - url: a valid String URL.
    ///   - completionHandler: a valid handler for the request.
    public func delete(url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        
        self.perform(method: HTTPMethod.POST, url : url, completionHandler : completionHandler)
        
    }
    
    /// Performs a valid PATCH into a valid informed URL.
    ///
    /// - Parameters:
    ///   - url: a valid String URL.
    ///   - completionHandler: a valid handler for the request.
    public func patch(url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        
        self.perform(method: HTTPMethod.PATCH, url : url, completionHandler : completionHandler)
        
    }
    
    /// Performs a valid PUT into a valid informed URL.
    ///
    /// - Parameters:
    ///   - url: a valid String URL.
    ///   - body: a String Body.
    ///   - completionHandler: a valid handler for the request.
    public func put(url: String, body: String? = nil, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {

        self.perform(method: HTTPMethod.PUT, url : url, body : body, completionHandler : completionHandler)
        
    }
    
    /// Performs a valid OPTIONS into a valid informed URL.
    ///
    /// - Parameters:
    ///   - url: a valid String URL.
    ///   - completionHandler: a valid handler for the request.
    public func options(url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        
        self.perform(method: HTTPMethod.OPTIONS, url : url, completionHandler : completionHandler)
        
    }
    
    /// Validates when a response have a result ok. CODE 200.
    ///
    /// - Parameters:
    ///   - response: a valid HTTP URLResponse.
    ///   - error: a error.
    /// - Returns: true if all is good, false otherwise.
    public func performOk(_ response: URLResponse? = nil, _ error: Error? = nil) -> Bool {
        
        var result = (error == nil)

        if let rs = response as? HTTPURLResponse {
            result = result && (rs.statusCode == 200)
        }
        
        return result

    }
    
}
