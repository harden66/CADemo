//
//  CAPopuopCustomView.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/4/2.
//

import UIKit

class CAPopuopCustomView: UIView {
    
    var clickSubscribe: BlockClickSubscribe?
    var clickClose: BlockClickClose?
    
    lazy var tapGesture = UITapGestureRecognizer()
    
    lazy var grayMaskView: UIView = {
        let grayMaskView = UIView()
        grayMaskView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        grayMaskView.addGestureRecognizer(tapGesture)
        return grayMaskView
    }()
    
    deinit {
        print("\((#file as NSString).lastPathComponent) dealloc")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        tapGesture.addTarget(self, action: #selector(action_close))
        //        setConstraints()
        //        setBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func showView(name: String, age: String, time: String, clickSubscribe: @escaping BlockClickSubscribe, clickClose: @escaping BlockClickClose) {
        let subscribePopView = CAPopuopCustomView()
        subscribePopView.clickSubscribe = clickSubscribe
        subscribePopView.clickClose = clickClose
        
        let window = UIApplication.shared.windows.last
        window?.addSubview(subscribePopView)
        subscribePopView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        //        window?.layoutIfNeeded()
        
        let backView = CAPrivacyView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 12
        subscribePopView.addSubview(backView)
        
        subscribePopView.alpha = 0
        UIView.animate(withDuration: 0.1) {
            subscribePopView.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                backView.snp.makeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(300)
                }
                //                subscribePopView.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func setUI() {
        addSubview(grayMaskView)
        grayMaskView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func action_close() {
        if let clickClose = clickClose {
            clickClose()
        }
        disMissView()
    }
    
    func disMissView() {
        clickSubscribe = nil
        clickClose = nil
        removeFromSuperview()
    }
}


class CAPrivacyView: UIView, UITextViewDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(self.contentTextView)
        self.contentTextView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.leading.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-50)
        }
        
                self.addSubview(self.lineView)
                self.lineView.snp.makeConstraints { make in
                    make.top.equalTo(self.contentTextView.snp.bottom).offset(6)
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(0.7)
                }
        
        self.addSubview(self.line2View)
        self.line2View.snp.makeConstraints { make in
            make.top.equalTo(self.lineView.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(0.7)
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(self.cancelBtn)
        self.cancelBtn.snp.makeConstraints { make in
            make.top.equalTo(self.lineView.snp.bottom)
            make.leading.bottom.equalToSuperview()
            make.trailing.equalTo(self.line2View.snp.leading)
        }
        
        self.addSubview(self.sureBtn)
        self.sureBtn.snp.makeConstraints { make in
            make.top.equalTo(self.lineView.snp.bottom)
            make.trailing.bottom.equalToSuperview()
            make.leading.equalTo(self.line2View.snp.trailing)
        }
    }
    
    
    fileprivate lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.isScrollEnabled = false
        textView.delegate = self
        textView.backgroundColor = .clear
        textView.textContainerInset = .zero
        let string = "依据监管要求，请您查阅以及。早您同意后，我们会收集您的Mac地址，以保障APP政策数据统计和安全风控。\n为了方便您的查阅，您可在ChatAI app“设置-使用条款”、“设置-隐私政策”中查看相应内容。"
        let tipString = "《使用条款》"
        let tip2String = "《隐私政策》"
        let font = UIFont.systemFont(ofSize: 16)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        let prefixAttributedText = NSMutableAttributedString(string: string, attributes: [.font: font, .foregroundColor: UIColor.black, .paragraphStyle: paragraphStyle])
        let suffixAttributedText = NSMutableAttributedString(string: tipString, attributes: [.link: "https://www.baidu.com", .underlineStyle: NSUnderlineStyle.single.rawValue])
        let suffixAttributedText2 = NSMutableAttributedString(string: tip2String, attributes: [.link: "https://www.baidu.com"/*, .underlineStyle: NSUnderlineStyle.single.rawValue*/])

        textView.linkTextAttributes = [.foregroundColor: UIColor.red,
                                       /*.underlineColor: UIColor.red,*/
                                       .font: font]
        prefixAttributedText.insert(suffixAttributedText, at: 11)
        prefixAttributedText.insert(suffixAttributedText2, at: 19)
        textView.attributedText = prefixAttributedText
        return textView
    }()
    
    fileprivate lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    fileprivate lazy var line2View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    fileprivate lazy var cancelBtn: UIButton = {
        let view = UIButton()
        return view
    }()
    
    fileprivate lazy var sureBtn: UIButton = {
        let view = UIButton()
        return view
    }()
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
    
}
