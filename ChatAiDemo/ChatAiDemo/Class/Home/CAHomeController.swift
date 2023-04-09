//
//  CAHomeController.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/3/19.
//

import UIKit
import SnapKit
import Moya

class CAHomeController: CABaseViewController, UITableViewDelegate, UITableViewDataSource, CAHomeCellDelegate {
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CAHomeCell.self, forCellReuseIdentifier: "CAHomeCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "AI Box"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
//        initSubViews()
//        makeConstraints()
//        initData()
    }
    
    func clickTruncationLabel(_ cell: CAHomeCell) {
        print("dddd")
    }
    
    // MARK: TableView的代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CAHomeCell", for: indexPath) as! CAHomeCell
        cell.delegate = self
        return cell
    }
    
    /// tableView的行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func initSubViews() {
        view.addSubview(truncationLabel)
    }
    func makeConstraints() {
        truncationLabel.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(200)
        }
    }
    func initData() {
        truncationLabel.attributedText = NSMutableAttributedString("时间最会骗人，但也能让你明白，这世界上是没有什么不能失去的！") { $0
            .font(.systemFont(ofSize: 14))
            .lineSpacing(5)
            .foregroundColor("#5E6582".uiColor)
            .lineBreakMode(.byWordWrapping)
        }.addText("离去的都是风景，留下的才是人生，走到最后的，才是对的人"){ $0
            .font(.systemFont(ofSize: 10))
            .lineSpacing(5)
            .foregroundColor(.red)
            .lineBreakMode(.byWordWrapping)
        }.addText("记住，要的是重新开始，并不是不从零开始，我们要带着过去所经历的困难和那些所明白的道理，继续走下去。"){ $0
            .font(.systemFont(ofSize: 18))
            .lineSpacing(5)
            .foregroundColor(.orange)
            .lineBreakMode(.byWordWrapping)
        }
        truncationLabel.truncationToken = (NSAttributedString(" ... [展开]"){ $0
            .foregroundColor("#1F70FF".uiColor)
            .font(.systemFont(ofSize: 28))
        }, NSAttributedString(" [折叠]"){ $0
            .foregroundColor("#1F70FF".uiColor)
            .font(.systemFont(ofSize: 28))
        })
        truncationLabel.reload(0)
    }

    private lazy var truncationLabel: CATruncationLabel = {
        let view = CATruncationLabel()
        view.numberOfLines = 3
        view.contentEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.borderWidth = 0.5
        view.addTarget(self, action: #selector(didClickLabelAction), for: .touchUpInside)
        return view
    }()

    @objc func didClickLabelAction()  {
        truncationLabel.isOpen.toggle()
        truncationLabel.reload(0)
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
        
        CAPopuopCustomView.showView(name: "我是张三", age: "18岁了", time: "就在今年") { text in
            print("收到了东西 \(text)")
        } clickClose: {
            print("点击关闭")
        }
    }
    
}

