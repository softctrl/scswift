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
    
    /// Just an alias to better represent an HTTP verb.
    public typealias Verb = String!
    
    /// Supported HTTP methods.
    public final class HTTPMethod {
        public static var GET : Verb = "GET"
        public static var POST : Verb = "POST"
        public static var DELETE : Verb = "DELETE"
        public static var PUT : Verb = "PUT"
        public static var PATCH : Verb = "PATCH"
        public static var OPTIONS : Verb = "OPTIONS"
    }
    
    /// Just an alias to better represent a valid Content type.
    public typealias ConType = String!
    
    /// HTTP Content Types.
    public final class ContentType {
        static var FIELD_NAME : String = "Content-Type"
        public static var JSON : ConType = "application/json"
        public static var STREAM : ConType = "application/octet-stream"
        public static var URL_ENCODED : ConType = "application/x-www-form-urlencoded"
        public static var XML : ConType = "application/xml"
        public static var JPEG : ConType = "image/jpeg"
        public static var PNG : ConType = "image/png"
        public static var GIF : ConType = "image/gif"
        public static var FORM_DATA : ConType = "multipart/form-data"
        public static var TEXT : ConType = "text/plain"
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
    ///   - body: If you want to send a body request.
    ///   - contentType: Inform a valid content type, or let application/json as default value.
    ///   - completionHandler: A closure that will handle the performed request.
    private func perform(method: String, url : String, body : String? = nil, contentType : ConType = ContentType.JSON, completionHandler : @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        
        let urlRequest : NSMutableURLRequest = self.createUrlRequest(method, URL(string: url)!)
        urlRequest.httpMethod = method

        //let jsonData = jsonStr.data(using: String.Encoding.utf8, allowLossyConversion: false)
        if let data = body?.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            urlRequest.httpBody = data
            urlRequest.addValue(String(data.count), forHTTPHeaderField : "content-length")
        }

        urlRequest.addValue(contentType, forHTTPHeaderField : ContentType.FIELD_NAME)
        
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest, completionHandler: completionHandler)

        task.resume()

    }
    
    /// Performs a valid GET into a valid informed URL.
    ///
    /// - Parameters:
    ///   - url: a valid String URL.
    ///   - completionHandler: a valid handler for the request.
    public func get(url: String, contentType : ConType = ContentType.JSON, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {

        print("URL: \(url)")
        self.perform(method: HTTPMethod.GET, url : url, contentType: contentType, completionHandler : completionHandler)

    }
    
    /// Performs a valid POST into a valid informed URL.
    ///
    /// - Parameters:
    ///   - url: a valid String URL.
    ///   - body: a String Body.
    ///   - completionHandler: a valid handler for the request.
    public func post(url: String, body: String? = nil, contentType : ConType = ContentType.JSON, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        print("POST\n\(body ?? "")\n")
        self.perform(method: HTTPMethod.POST, url : url, body: body, contentType: contentType, completionHandler : completionHandler)
        
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
    public func put(url: String, body: String? = nil, contentType : ConType = ContentType.JSON, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {

        self.perform(method: HTTPMethod.PUT, url : url, body : body, contentType : contentType, completionHandler : completionHandler)
        
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
