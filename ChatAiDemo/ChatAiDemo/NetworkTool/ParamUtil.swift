//
//  ParamUtil.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/3/27.
//

import Foundation
import Moya

class ParamUtil {
    static func urlRequestParamters(_ data:[String: Any]) -> Task {
        return .requestParameters(parameters: data, encoding: URLEncoding.default)
    }
}
