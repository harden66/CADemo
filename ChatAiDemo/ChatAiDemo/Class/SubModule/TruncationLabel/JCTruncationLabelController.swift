//
//  JCTruncationLabelController.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/4/13.
//

import UIKit

class JCTruncationLabelController: CABaseViewController,UITableViewDelegate, UITableViewDataSource, CATruncationCellDelegate {
    
    var dataSource: [CATruncationModel] = []
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CAHTruncationCell.self, forCellReuseIdentifier: "CAHTruncationCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "AI Box"
        self.dataSource.append(CATruncationModel.createModel(height: 150))
        self.dataSource.append(CATruncationModel.createModel(height: 150))
        self.dataSource.append(CATruncationModel.createModel(height: 150))

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func clickTruncationLabel(_ cell: CAHTruncationCell) {
        print("dddd")
//        tableView.reloadData()
        let currentIndexPath = tableView.indexPath(for: cell)
        tableView.reloadRows(at: [currentIndexPath ?? IndexPath()], with: .none)
    }
    
    // MARK: TableView的代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CAHTruncationCell", for: indexPath) as! CAHTruncationCell
        let model = self.dataSource[indexPath.row]
        cell.model = model
        cell.delegate = self
        return cell
    }
    
    /// tableView的行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.dataSource[indexPath.row]
        return CGFloat(model.cellHeight!)
    }
    
}


protocol CATruncationCellDelegate: NSObjectProtocol {
    
    /// 点击展开label的回调
    func clickTruncationLabel(_ cell: CAHTruncationCell)
}

class CAHTruncationCell: UITableViewCell {
    
    var delegate: CATruncationCellDelegate?
    var model: CATruncationModel?
    
    private lazy var truncationLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 3
//        view.contentEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        view.layer.cornerRadius = 5
//        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.borderWidth = 0.5
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didClickLabelAction)))
//        view.addTarget(self, action: #selector(didClickLabelAction), for: .touchUpInside)
        return view
    }()
    
    @objc func didClickLabelAction()  {
//        truncationLabel.isOpen.toggle()
//        model?.truncationOpen = truncationLabel.isOpen
//        truncationLabel.reload(0)
        print("ddddddddddddd")
        model?.truncationOpen = !(model?.truncationOpen ?? false)
        model?.cellHeight = (model?.truncationOpen)! ? 200 : 150
        delegate?.clickTruncationLabel(self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(truncationLabel)
        truncationLabel.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(30)
        }
        truncationLabel.attributedText = NSMutableAttributedString("时间最会骗人，但也能让你明白，这世界上是没有什么不能失去的！离去的都是风景，留下的才是人生，走到最后的，才是对的人,记住，要的是重新开始，并不是不从零开始，我们要带着过去所经历的困难和那些所明白的道理，继续走下去。") { $0
            .font(.systemFont(ofSize: 14))
            .lineSpacing(5)
            .foregroundColor("#5E6582".uiColor)
            .lineBreakMode(.byWordWrapping)
        }
//        truncationLabel.truncationToken = (NSAttributedString(" ... [展开]"){ $0
//            .foregroundColor("#1F70FF".uiColor)
//            .font(.systemFont(ofSize: 14))
//        }, NSAttributedString(" [折叠]"){ $0
//            .foregroundColor("#1F70FF".uiColor)
//            .font(.systemFont(ofSize: 14))
//        })
//        setNeedsLayout()
//        layoutIfNeeded()
        print("cell中label的宽度：\(truncationLabel.bounds.width), \(self.bounds.size.width)")
//        truncationLabel.reload(343)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CATruncationModel: NSObject {
    var cellHeight: Int?
    var truncationOpen: Bool? = false
    
    class func createModel(height: Int) -> CATruncationModel {
        let model = CATruncationModel()
        model.cellHeight = height
        return model
    }
}
