//
//  guideTwoController.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/4/2.
//

import UIKit

class guideTwoController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        self.view.addSubview(self.logoImgView)
        self.logoImgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(150)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        self.view.addSubview(self.helpLabel)
        self.helpLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.logoImgView.snp.bottom).offset(15)
            make.height.equalTo(30)
        }
        
        self.view.addSubview(self.describeLabel)
        self.describeLabel.numberOfLines = 0
        self.describeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.top.equalTo(self.helpLabel.snp.bottom).offset(15)
        }
    }
    
    fileprivate lazy var logoImgView: UIImageView = {
       let imgView = UIImageView()
        imgView.backgroundColor = .blue
        return imgView
    }()
    
    fileprivate lazy var helpLabel:UILabel = UILabel.creatLabel("请帮帮我们", 20, .center)
    
    fileprivate lazy var describeLabel:UILabel = UILabel.creatLabel("我们需要您在App Store上的评价，来帮助我们改善产品已寄给您提供更好的用户体验。", 16, .center)

}
