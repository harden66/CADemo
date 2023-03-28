//
//  CAPopoupView.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/3/28.
//

import UIKit

typealias BlockClickSubscribe = (_ text: String) -> Void
typealias BlockClickClose = () -> Void

class CAPopoupView: UIView {
    static let buttonHeight: CGFloat = 52
        
        var clickSubscribe: BlockClickSubscribe?
        var clickClose: BlockClickClose?
        
        lazy var tapGesture = UITapGestureRecognizer()
        
        lazy var grayMaskView: UIView = {
            let grayMaskView = UIView()
            grayMaskView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            grayMaskView.addGestureRecognizer(tapGesture)
            return grayMaskView
        }()
        
        lazy var backView: UIView = {
            let backView = UIView()
            backView.backgroundColor = UIColor.white
            backView.layer.cornerRadius = 12
            return backView
        }()
        
        private lazy var shadowBar: OutageShadowBar = {
            let shadowBar = OutageShadowBar()
            return shadowBar
        }()
        
        lazy var subscribeButton: UIButton = {
            let subscribeButton = UIButton()
            subscribeButton.setTitle("这是我的标题", for: .normal)
            subscribeButton.setTitleColor(UIColor.blue, for: .normal)
            subscribeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            return subscribeButton
        }()
        
        lazy var cancelButton: UIButton = {
            let cancelButton = UIButton()
            cancelButton.setTitle("取消", for: .normal)
            cancelButton.setTitleColor(UIColor.blue, for: .normal)
            cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            cancelButton.backgroundColor = UIColor.purple.withAlphaComponent(0.1)
            return cancelButton
        }()
        
        lazy var topRightCloseButton: UIButton = {
            let topRightCloseButton = UIButton()
            topRightCloseButton.backgroundColor = UIColor.green
            topRightCloseButton.setTitle("关闭", for: .normal)
            topRightCloseButton.setTitleColor(UIColor.red, for: .normal)
            return topRightCloseButton
        }()
        
        lazy var contentGrayView: UIView = {
            let contentGrayView = UIView()
            contentGrayView.layer.cornerRadius = 10
            contentGrayView.backgroundColor = UIColor.yellow
            return contentGrayView
        }()
        
        lazy var contentLabel: UILabel = {
            let contentLabel = UILabel()
            contentLabel.numberOfLines = 0
            return contentLabel
        }()
        
        lazy var titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            titleLabel.textColor = UIColor.black
            titleLabel.text = "我停电了"
            return titleLabel
        }()
        
        deinit {
            print("\((#file as NSString).lastPathComponent) dealloc")
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setUI()
            setConstraints()
            setBindings()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // 这段代码需要抽取出来, 左晨公用的
        static func getAttributeString(firstText: String) -> NSMutableAttributedString {
            let attributeString = NSMutableAttributedString(string: firstText)
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .natural
            let multipleAttributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: paragraph,
                .font: UIFont.systemFont(ofSize: 16, weight: .regular),
                .foregroundColor: UIColor.black]
            attributeString.addAttributes(multipleAttributes, range: NSRange(location: 0, length: firstText.count))
            
            let indexArray: [Int] = firstText.indicesOf(string: "\"")
            let indexCount = indexArray.count
            if indexCount % 2 == 0 {
                for i in stride(from: 0, to: indexArray.count - 1, by: 2) {
                    attributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .bold), range: NSRange(location: indexArray[i] + 1, length: indexArray[i+1] - indexArray[i] - 1))
                    attributeString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: indexArray[i] + 1, length: indexArray[i+1] - indexArray[i] - 1))
                }
            }
            return attributeString
        }
        
        static func showView(name: String, age: String, time: String, clickSubscribe: @escaping BlockClickSubscribe, clickClose: @escaping BlockClickClose) {
            let subscribePopView = CAPopoupView()
            subscribePopView.clickSubscribe = clickSubscribe
            subscribePopView.clickClose = clickClose
            
            let formatString = String(format: "这是内容,内容里面有文字样式是\"被引用加粗的文字\"这个就是重点啊,然后还有3个占位符%@AAA%@BBB%@CCC", name, age, time)
            subscribePopView.contentLabel.attributedText = CAPopoupView.getAttributeString(firstText: formatString)
            
            let window = UIApplication.shared.windows.last
            window?.addSubview(subscribePopView)
            subscribePopView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            window?.layoutIfNeeded()
            subscribePopView.alpha = 0
            UIView.animate(withDuration: 0.1) {
                subscribePopView.alpha = 1
            } completion: { _ in
                UIView.animate(withDuration: 0.1, animations: {
                    subscribePopView.backView.snp.updateConstraints { make in
                        // for layout animation in view presenting from bottom, content height depend on subviews
                        make.top.equalTo(subscribePopView.snp.bottom).offset(-subscribePopView.backView.frame.height)
                    }
                    subscribePopView.layoutIfNeeded()
                }, completion: nil)
            }
        }
        
        func setUI() {
            addSubview(grayMaskView)
            addSubview(backView)
            backView.addSubview(cancelButton)
            backView.addSubview(shadowBar)
            backView.addSubview(subscribeButton)
            backView.addSubview(topRightCloseButton)
            backView.addSubview(contentGrayView)
            contentGrayView.addSubview(contentLabel)
            backView.addSubview(titleLabel)
        }
        
        func setConstraints() {
            grayMaskView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            backView.snp.makeConstraints { make in
                // for layout animation in view presenting from bottom, content height depend on subviews
                make.top.equalTo(self.snp.bottom).offset(0)
                make.left.right.equalToSuperview()
            }
            
            var safeBottomHeight: CGFloat = 0
            if #available(iOS 11.0, *) {
                safeBottomHeight = UIApplication.shared.windows.last?.safeAreaInsets.bottom ?? 0
            } else {
                // Fallback on earlier versions
            }
            cancelButton.snp.makeConstraints { make in
                make.bottom.equalTo(-safeBottomHeight-20)
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.height.equalTo(CAPopoupView.buttonHeight)
            }
            shadowBar.snp.makeConstraints { make in
                make.bottom.equalTo(cancelButton.snp.top).offset(-30)
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.height.equalTo(CAPopoupView.buttonHeight)
            }
            subscribeButton.snp.makeConstraints { make in
                make.edges.equalTo(shadowBar)
            }
            contentGrayView.snp.makeConstraints { make in
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.bottom.equalTo(shadowBar.snp.top).offset(-20)
            }
            contentLabel.snp.makeConstraints { make in
                make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            }
            titleLabel.snp.makeConstraints { make in
                make.left.equalTo(20)
                make.right.equalTo(topRightCloseButton.snp.left).offset(-13)
                make.bottom.equalTo(contentGrayView.snp.top).offset(-20)
                make.top.equalTo(20)
            }
            topRightCloseButton.snp.makeConstraints { make in
                make.centerY.equalTo(titleLabel)
                make.right.equalToSuperview().offset(-13)
                make.height.width.equalTo(44)
            }
        }
        
        func setBindings() {
            topRightCloseButton.addTarget(self, action: #selector(action_close), for: .touchUpInside);
            cancelButton.addTarget(self, action: #selector(action_close), for: .touchUpInside);
            tapGesture.addTarget(self, action: #selector(action_close))
            subscribeButton.addTarget(self, action: #selector(action_subscribe), for: .touchUpInside);
        }
        
        @objc func action_close() {
            if let clickClose = clickClose {
                clickClose()
            }
            disMissView()
        }
        
        @objc func action_subscribe() {
            if let clickSubscribe = clickSubscribe {
                clickSubscribe("9789697979865469789")
            }
            disMissView()
        }
        
        func disMissView() {
            clickSubscribe = nil
            clickClose = nil
            removeFromSuperview()
        }
    }

    class OutageShadowBar: UIView {
        let cornerRadius:CGFloat = CAPopoupView.buttonHeight * 0.5
        override var bounds: CGRect {
            didSet {
                setupShadow()
            }
        }
        private func setupShadow() {
            backgroundColor = UIColor.white
            layer.cornerRadius = cornerRadius
            layer.borderWidth = 1
            layer.borderColor = UIColor.white.cgColor
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.1
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        }
    }

    public extension String {
        func indicesOf(string: String) -> [Int] {
            var indices = [Int]()
            var searchStartIndex = self.startIndex
            while searchStartIndex < self.endIndex, let range = self.range(of: string, range: searchStartIndex..<self.endIndex), !range.isEmpty {
                let index = distance(from: self.startIndex, to: range.lowerBound)
                indices.append(index)
                searchStartIndex = range.upperBound
            }
            return indices
        }
}
