//
//  ViewController.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/3/19.
//

import UIKit
import SnapKit
import Moya

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "AI Box"
        
        let textFeild = UITextField(frame: CGRect(x: 20, y: 120, width: 200, height: 30))
        textFeild.borderStyle = .roundedRect
        textFeild.textColor = .red
        textFeild.textAlignment = .left
        textFeild.placeholder = "请输入姓名"
        self.view.addSubview(textFeild)
        
        let btn = UIButton()
        btn.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        btn.backgroundColor = .red
        self.view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        let model1 = CAChatModel.createModel("1", "harden", 1)
        let model2 = CAChatModel.createModel("harden", "1", 2)
        let model3 = CAChatModel.createModel("1", "harden", 3)
        let model4 = CAChatModel.createModel("harden", "1", 4)
        let model5 = CAChatModel.createModel("1", "harden", 5)
        let model6 = CAChatModel.createModel("harden", "1", 6)
        let model7 = CAChatModel.createModel("1", "harden", 7)
        let model8 = CAChatModel.createModel("harden", "1", 8)
        let model9 = CAChatModel.createModel("1", "harden", 9)
        let model10 = CAChatModel.createModel("harden", "1", 10)
        
        let arr: [CAChatModel] = [model1, model2, model3, model4, model5, model6, model7, model8, model9, model10]
        
        print("1")
        let sendArr: [CAChatModel] = arr.filter { $0.send_id == "1" }
        let repleArr: [CAChatModel] = arr.filter { $0.repley_id == "1" }
        let tempArr = sendArr.flatMap { send in
            repleArr.map { reply in
                compareModel(send, reply)
            }
        }
        let resultArr1 = tempArr.filter { $0?.count ?? 0 > 0 }
        let resultArr2 = tempArr.filter { !($0?.isEmpty ?? true) }
        print("2")
        
        var dasdkArr: [Any] = []
        for (index, element) in arr.enumerated() {
            if (index > 0) {
                let lastElement = arr[index - 1]
                if (lastElement.send_id == "1" && element.repley_id == "1") {
                    dasdkArr.append([lastElement, element])
                }
            }
            print(index,element)
        }
        print("3")
        
        
        
        
        
        
        self.view.addSubview(self.label1)
        self.label1.frame = CGRect(x: 100, y: 150, width: 200, height: 50)
        
        
        
        
        
    }
    
    
    lazy var label1: UILabel = UILabel.creatLabel("ddddd")
    
    
    func compareModel(_ a:CAChatModel, _ b: CAChatModel) -> Array<Any>? {
        if (((a.id ?? 0) + 1 == b.id) && a.send_id == "1" && b.repley_id == "1") {
            return [a,b]
        }
        return nil
    }
    
    @objc func buttonDidClick() {
        let provider = MoyaProvider<DefaultService>()
        provider.request(.sheets(size: 10)) { result in
            print(result)
            switch result {
            case let .success(Response):
                let data = Response.data
                let code = Response.statusCode
                let dataString = String(data: data, encoding: .utf8)
                print("request result\n stateCode:\(code),\n data:\(String(describing: dataString))")
            case let .failure(Error):
                print("request result\n stateCode:\(Error)")
            }
        }
        
        /*
         <Parameters: Encodable>(_ convertible: URLConvertible,
                                                  method: HTTPMethod = .get,
                                                  parameters: Parameters? = nil,
                                                  encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default,
                                                  headers: HTTPHeaders? = nil,
                                                  interceptor: RequestInterceptor? = nil,
                                                  requestModifier: RequestModifier? = nil)
         */
        
        
        
        CAPopuopCustomView.showView(name: "我是张三", age: "18岁了", time: "就在今年") { text in
            print("收到了东西 \(text)")
        } clickClose: {
            print("点击关闭")
        }
        
//        let alertController = UIAlertController(title: "我是警告框弹窗", message: "", preferredStyle: .actionSheet)
        
//        self.navigationController?.pushViewController(guideController(), animated: true)
    }
    
}

