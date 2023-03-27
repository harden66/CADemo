//
//  RequestTool.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/3/27.
//

import Foundation
//import SwiftyJSON
//
//typealias CompletionHandle = (JSON?, _ error: Error?) -> Any?
//typealias ResponseBlock = (Any?, _ isCache: Bool, _ error: Error?) -> Void
//
///// 请求参数;
//enum RequestParams {
//    case string(String)
//    case number(NSNumber)
//    case data(Data)
//}
//
///// 请求类型;
//enum RequestType: Int {
//    case get = 0
//    case post
//    case download
//    case upload
//}
//
//class ResponseHandler<T> {
//    var success: ((T) -> Void)?
//    var error: ((Error) -> Void)?
//    var always: ((T?, Error?) -> Void)?
//
//    init() {
//
//    }
//
//    func on(success: ((T) -> Void)? = nil, error: ((Error) -> Void)? = nil, always: ((T?, Error?) -> Void)? = nil) {
//        self.success = success
//        self.error = error
//        self.always = always
//    }
//}
//
//// MARK: - 通过协议更加简单的实例化;
//extension RequestParams: ExpressibleByStringLiteral {
//
//    init(stringLiteral value: StringLiteralType) {
//        self = .string(value)
//    }
//
//    init(extendedGraphemeClusterLiteral value: StringLiteralType) {
//        self = .string(value)
//    }
//
//    init(unicodeScalarLiteral value: StringLiteralType) {
//        self = .string(value)
//    }
//}
//
//extension RequestParams: ExpressibleByIntegerLiteral {
//    init(integerLiteral value: IntegerLiteralType) {
//        self = .number(NSNumber(integerLiteral: value))
//    }
//}
//
//extension RequestParams: ExpressibleByBooleanLiteral {
//    init(booleanLiteral value: BooleanLiteralType) {
//        self = .number(NSNumber(booleanLiteral: value))
//    }
//}
//
//extension RequestParams: ExpressibleByFloatLiteral {
//    init(floatLiteral value: FloatLiteralType) {
//        self = .number(NSNumber(floatLiteral: value))
//    }
//}
//
///// 网络配置枚举;
//struct RequestOptions: OptionSet {
//    var rawValue: Int
//
//    init(rawValue: Int) {
//        self.rawValue = rawValue
//    }
//
//    static let none = RequestOptions(rawValue: 0)
//    static let useHttps = RequestOptions(rawValue: 1 << 0)
//    static let disableCache = RequestOptions(rawValue: 1 << 1)
//    static let ignoreCacheBeforeRequest = RequestOptions(rawValue: 1 << 2)
//    static let disableRetry = RequestOptions(rawValue: 1 << 3)
//    static let needDecode = RequestOptions(rawValue: 1 << 4)
//}

private let kNetworkRequestRetryTimes = 2 ///重新请求时间
private let kRequestErrorDomain = "com.WMark.request" ///请求错误信息

class RequestTool: NSObject {
    var apiResource = ""       ///api资源,如login;
    var isCloudOfficeAPI = true   /// 是否是组织api
    var gid: String?              /// 企业ID,不传默认为当前企业,不需要时传""
}


