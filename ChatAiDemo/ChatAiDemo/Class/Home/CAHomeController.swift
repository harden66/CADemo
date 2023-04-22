//
//  CAHomeController.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/3/19.
//

import UIKit
import SnapKit
import Moya

class CAHomeController: CABaseViewController, UITableViewDelegate, UITableViewDataSource {
    var dataSource: [[String: String]] = []
    var signle: Bool = true
    var semaphore = DispatchSemaphore.init(value: 0)
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CAHomeCell")
        return tableView
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("dddd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Home"
        
        dataSource = [["JCTruncationLabelController": "TableView中cell加载展开收起的Label"],
                      ["JCArrayOperationController": "对象数组操作"]]
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        
        
        
        
        let queue = DispatchQueue(label: "com.chaoone.td", qos: .utility, attributes: .concurrent)
        queue.async {
            while (self.signle) {
                print("dddddddd \(Thread.current)")
                DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                    
                    let provider = MoyaProvider<DefaultService>()
                    provider.request(.sheets(size: 10)) { result in
                        print(result)
                        self.semaphore.signal()
                        switch result {
                        case let .success(Response):
                            let data = Response.data
                            let code = Response.statusCode
                            let dataString = String(data: data, encoding: .utf8)
                            print("request result\n stateCode:\(code),\n data:\(String(describing: dataString))")
                        case let .failure(Error):
                            print("request result\n stateCode:\(Error)")
                        }
                        print("dduu \(Thread.current)")
                        if (self.signle) {
                            
                            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
                        }
                    }
                }
                self.semaphore.wait()

            }
        }
        
        
        
        
    }
    
    // MARK: TableView的代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CAHomeCell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row].values.first
        return cell
    }
    
    /// tableView的行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.signle = false
        let controller = classFromStr(dataSource[indexPath.row].keys.first ?? "")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func classFromStr(_ className:String) -> UIViewController{
        //Swift中命名空间的概念
        var name = Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") as? String
        name = name?.replacingOccurrences(of: "-", with: "_")
        let fullClassName = name! + "." + className
        guard let classType = NSClassFromString(fullClassName) as? UIViewController.Type  else{
            fatalError("转换失败")
        }
        return classType.init()
    }
    
}

