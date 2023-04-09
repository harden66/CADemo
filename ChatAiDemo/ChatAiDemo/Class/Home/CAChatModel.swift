//
//  CAChatModel.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/3/31.
//

import Foundation

class CAChatModel: NSObject {
     
    var send_id: String?
    var repley_id: String?
    var id: Int?
    
    class func createModel(_ sendId: String, _ repleyId: String, _ id: Int) -> CAChatModel {
        let model = CAChatModel()
        model.send_id = sendId
        model.repley_id = repleyId
        model.id = id
        return model
    }
}
