//
//  UILabel+Extension.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/4/1.
//

import UIKit

extension UILabel {
    class  func creatLabel(_ text: String? = nil, _ fontSize: Int? = nil, _ align: NSTextAlignment? = .left)->UILabel{
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.textAlignment = align!
        label.font = UIFont.systemFont(ofSize: CGFloat(fontSize ?? 16), weight: .bold)
        return label
    }
}
