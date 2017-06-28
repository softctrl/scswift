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
    
    
    
    
//    private var urlRequest : NSMutableURLRequest
//    private var baseUrl : String = ""
    
    /// Default constructor.
    ///
    /// - Parameter baseUrl: <#baseUrl description#>
//    public init(baseUrl : String) {
//        
////        self.baseUrl = baseUrl
//        super.init()
//        
//    }

    /// <#Description#>
    public override init() {

        super.init()
        
    }
    
    /// <#Description#>
    ///
    /// - Parameter method: <#method description#>
    /// - Returns: <#return value description#>
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
        
        urlRequest.addValue(ContentType.JSON, forHTTPHeaderField : ContentType.FIELD_NAME)
        
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest, completionHandler: completionHandler)

        task.resume()

    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - url: <#url description#>
    ///   - completionHandler: <#completionHandler description#>
    public func get(url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {

        self.perform(method: HTTPMethod.GET, url : url, completionHandler : completionHandler)

    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - url: <#url description#>
    ///   - completionHandler: completionHandler description
    public func post(url: String, body: String? = nil, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        print("\(body ?? "")\n")
        self.perform(method: HTTPMethod.POST, url : url, body: body, completionHandler : completionHandler)
        
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - url: <#url description#>
    ///   - completionHandler: <#completionHandler description#>
    public func delete(url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        
        self.perform(method: HTTPMethod.POST, url : url, completionHandler : completionHandler)
        
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - url: <#url description#>
    ///   - completionHandler: <#completionHandler description#>
    public func patch(url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        
        self.perform(method: HTTPMethod.PATCH, url : url, completionHandler : completionHandler)
        
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - url: <#url description#>
    ///   - body: <#body description#>
    ///   - completionHandler: <#completionHandler description#>
    public func put(url: String, body: String? = nil, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {

        self.perform(method: HTTPMethod.PUT, url : url, body : body, completionHandler : completionHandler)
        
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - url: <#url description#>
    ///   - completionHandler: <#completionHandler description#>
    public func options(url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        
        self.perform(method: HTTPMethod.OPTIONS, url : url, completionHandler : completionHandler)
        
    }
    
}
