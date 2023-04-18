//
//  UIView+Extension.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/4/18.
//

import UIKit

extension UIView {
    /// 闪烁动画
    func addFlicker() {
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.fromValue = 1
        anim.toValue = 0
        anim.autoreverses = true
        anim.duration = 1
        anim.repeatCount = MAXFLOAT
        anim.isRemovedOnCompletion = false
        anim.fillMode = .forwards
        anim.timingFunction = CAMediaTimingFunction.init(name: .easeIn) //没有的话是均匀的动画
        self.layer.add(anim, forKey: nil)
    }
    
    // 移除view上的动画
    func removeAnimation() {
        self.layer.removeAllAnimations()
    }
}
