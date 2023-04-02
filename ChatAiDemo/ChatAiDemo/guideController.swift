//
//  guideController.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/4/2.
//

import UIKit

class guideController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        self.view.addSubview(self.logoImgView)
        self.logoImgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(150)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        self.view.addSubview(self.welcomeLabel)
        self.welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.logoImgView.snp.bottom).offset(15)
            make.height.equalTo(30)
        }
        
        self.view.addSubview(self.guidanceView)
        self.guidanceView.snp.makeConstraints { make in
            make.top.equalTo(self.welcomeLabel.snp.bottom).offset(15)
            make.height.equalTo(300)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
        }
        
        self.view.addSubview(self.exploreLabel)
        self.exploreLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.guidanceView.snp.bottom).offset(15)
        }
        CAPopoupView.showView(name: "我是张三", age: "18岁了", time: "就在今年") { text in
            print("收到了东西 \(text)")
        } clickClose: {
            print("点击关闭")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.navigationController?.pushViewController(guideTwoController(), animated: true)
    }
    
    fileprivate lazy var logoImgView: UIImageView = {
       let imgView = UIImageView()
        imgView.backgroundColor = .blue
        return imgView
    }()
    
    fileprivate lazy var welcomeLabel:UILabel = UILabel.creatLabel("欢迎来到ChatAI 助手", 20, .center)
    
    fileprivate lazy var guidanceView: CAGuidanceView = {
        let view = CAGuidanceView()
        view.layer.cornerRadius = 14
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        return view
    }()
    
    fileprivate lazy var exploreLabel:UILabel = UILabel.creatLabel("等你探索", 16, .center)

}

class CAGuidanceView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(self.helpYouLabel)
        self.helpYouLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
        }
        
        self.addSubview(self.guideOneView)
        self.guideOneView.titleString = "回答任何问题"
        self.guideOneView.describeString = "我能回答任何问题，你能想到的我都能回答"
        self.guideOneView.imgString = ""
        self.guideOneView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.helpYouLabel.snp.bottom).offset(15)
            make.height.equalTo(50)
        }
        
        self.addSubview(self.guideTwoView)
        self.guideTwoView.titleString = "帮你写作"
        self.guideTwoView.describeString = "按照您的主题要求，生成各种文章或大纲"
        self.guideTwoView.imgString = "icon_icon"
        self.guideTwoView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.guideOneView.snp.bottom).offset(15)
            make.height.equalTo(50)
        }
        
        self.addSubview(self.guideThreeView)
        self.guideThreeView.titleString = "话术回复"
        self.guideThreeView.describeString = "提供聊天和邮件的话术回复，帮您解决回复难问题"
        self.guideThreeView.imgString = "icon_icon"
        self.guideThreeView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.guideTwoView.snp.bottom).offset(15)
            make.height.equalTo(50)
        }
    }
    
    fileprivate lazy var helpYouLabel:UILabel = UILabel.creatLabel("我能帮你", 16, .center)
    
    fileprivate lazy var guideOneView:CAGuidItemView = {
        return CAGuidItemView()
    }()

    fileprivate lazy var guideTwoView:CAGuidItemView = {
        return CAGuidItemView()
    }()
    
    fileprivate lazy var guideThreeView:CAGuidItemView = {
        return CAGuidItemView()
    }()
}

class CAGuidItemView: UIView {
    
    var titleString: String? {
        didSet {
            self.titleLabel.text = titleString
        }
    }
    var describeString: String? {
        didSet {
            self.describeLabel.text = describeString
        }
    }
    var imgString: String? {
        didSet {
            if let imgStr = imgString {
                self.iconView.image = UIImage(named: imgStr)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(self.iconView)
        self.iconView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.iconView)
            make.leading.equalTo(self.iconView.snp.trailing).offset(10)
        }
        
        self.addSubview(self.describeLabel)
        self.describeLabel.numberOfLines = 0
        self.describeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(6)
            make.leading.equalTo(self.iconView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
    
    
    fileprivate lazy var iconView: UIImageView = {
       let imgView = UIImageView()
        imgView.backgroundColor = .blue
        return imgView
    }()
    
    fileprivate lazy var titleLabel:UILabel = UILabel.creatLabel("欢迎来到ChatAI 助手", 16)
    
    fileprivate lazy var describeLabel:UILabel = UILabel.creatLabel("欢迎来到ChatAI 助手", 14)
}
