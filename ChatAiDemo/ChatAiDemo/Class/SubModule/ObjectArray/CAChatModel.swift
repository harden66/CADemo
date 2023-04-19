//
//  CAChatModel.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/3/31.
//

import Foundation

class CAChatModel: NSObject {
    
    @objc var send_id: String?
    @objc var repley_id: String?
    @objc var id: Int = 0
    
    class func createModel(_ sendId: String, _ repleyId: String, _ id: Int) -> CAChatModel {
        let model = CAChatModel()
        model.send_id = sendId
        model.repley_id = repleyId
        model.id = id
        return model
    }
    
    override var description: String {
        let properties = ["id", "send_id", "repley_id"]
        return "\(dictionaryWithValues(forKeys: properties))"
    }
}
