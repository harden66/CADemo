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
        
        CAPopoupView.showView(name: "我是张三", age: "18岁了", time: "就在今年") { text in
                    print("收到了东西 \(text)")
                } clickClose: {
                    print("点击关闭")
                }
    }

}

