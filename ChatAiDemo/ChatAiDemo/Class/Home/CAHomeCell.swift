//
//  CAHomeCell.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/4/10.
//

import UIKit

protocol CAHomeCellDelegate: NSObjectProtocol {
    
    /// 点击展开label的回调
    func clickTruncationLabel(_ cell: CAHomeCell)
}

class CAHomeCell: UITableViewCell {
    
    var delegate: CAHomeCellDelegate?
    
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
        truncationLabel.truncationToken = (NSAttributedString(" ... [展开]"){ $0
            .foregroundColor("#1F70FF".uiColor)
            .font(.systemFont(ofSize: 14))
        }, NSAttributedString(" [折叠]"){ $0
            .foregroundColor("#1F70FF".uiColor)
            .font(.systemFont(ofSize: 14))
        })
//        setNeedsLayout()
//        layoutIfNeeded()
        print("cell中label的宽度：\(truncationLabel.bounds.width), \(self.bounds.size.width)")
        truncationLabel.reload(343)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
