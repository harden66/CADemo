//
//  JCArrayOperationController.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/4/20.
//

import UIKit

class JCArrayOperationController: CABaseViewController {
    
    var dataSource: [CAChatModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.append(CAChatModel.createModel("1", "1", 1))
        dataSource.append(CAChatModel.createModel("1", "1", 2))
        dataSource.append(CAChatModel.createModel("1", "1", 5))
        dataSource.append(CAChatModel.createModel("1", "1", 3))
        dataSource.append(CAChatModel.createModel("1", "1", 4))
        dataSource.append(CAChatModel.createModel("1", "1", 7))
        dataSource.append(CAChatModel.createModel("1", "1", 8))
        dataSource.append(CAChatModel.createModel("1", "1", 6))
        
        // 获取指定某个元素在数组中第一个的下标
        let index = dataSource.firstIndex { $0.id == 6}
        print("\(String(describing: index))")
        
        // 对数组升序排列d
        dataSource.sort { $0.id > $1.id }
        print("\(dataSource)")
        dataSource.sort(by: sorterByPersonAgeDESC)
        print("\(dataSource)")

    }
    
    func sorterByPersonAgeDESC(model1:CAChatModel, model2:CAChatModel) -> Bool {
        return model1.id < model2.id
    }
}
