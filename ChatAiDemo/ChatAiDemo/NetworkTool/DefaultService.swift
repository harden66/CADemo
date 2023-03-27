//
//  DefaultService.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/3/27.
//

import Foundation
import Moya

enum DefaultService {
    /// 广告列表
    case ads(position: Int)
    
    /// 歌单列表
    case sheets(size: Int)
    
    case sigister(data: User)
    
}

extension DefaultService: TargetType {
    var baseURL: URL {
        return URL(string: Config.ENDPOINT)!
    }
    
    var path: String {
        switch self {
        case .ads(_):
            return "v1/ads"
        case .sheets:
            return "v1/sheets"
        case .sigister(_):
            return "v1/users"
        default:
            fatalError("DefaultService path is null!!!")
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sigister(_):
            return .post
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .ads(let position):
            return ParamUtil.urlRequestParamters(["position": position])
        case .sheets(let size):
            return ParamUtil.urlRequestParamters(["size": size])
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var headers: Dictionary<String, String> = [:]
        return headers
    }
    
    
}
