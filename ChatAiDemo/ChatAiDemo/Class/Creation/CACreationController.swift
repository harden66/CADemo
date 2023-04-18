//
//  CACreationController.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/4/9.
//

import UIKit
import ZLPhotoBrowser

class CACreationController: CABaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var typingLabel: UILabel!
    
    var animationTimer: Timer?
    var textView: UITextView!
    var eeeee: UIView!
    
    // MARK: - ViewLifecycle
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animationTimer?.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ebtnClick = UIButton()
        ebtnClick.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        ebtnClick.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        ebtnClick.backgroundColor = .red
        view.addSubview(ebtnClick)
        
        let textVIEW = UITextView(frame: CGRect(x: 20, y: 200, width: 300, height: 300))
        textVIEW.layer.borderColor = UIColor.red.cgColor
        textVIEW.layer.borderWidth = 1
        textVIEW.text = ""
        let rect = textVIEW.caretRect(for: textVIEW.selectedTextRange!.end)
        let eeee = UIView(frame: CGRect(x: rect.origin.x + 2, y: rect.origin.y, width: rect.size.width, height: rect.size.height))
        eeee.backgroundColor = UIColor.red
//        self.setlights(view: eeee)
        textVIEW.addSubview(eeee)
        self.textView = textVIEW
        self.eeeee = eeee
        self.view.addSubview(textVIEW)
    }
    
    func setlights(view: UIView) {
        view.alpha = 0
        UIView.animate(withDuration: 1) {
            view.alpha = 1
        }completion: { animation in
            self.setlights(view: view)
        }
    }
    
    // MARK: - ButtonActions
    
    @IBAction func animatorButtonPressed(_ sender: Any) {
        animateText()
    }
    
    @objc func clickBtn() {
        
        self.textView.text = "我是垃圾对方拉设计费大厦撒来得及福利卡试卷得分阿萨德路附近"
        let rect = self.textView.caretRect(for: self.textView.selectedTextRange!.end)
        self.eeeee.frame = CGRect(x: rect.origin.x + 2, y: rect.origin.y, width: rect.size.width, height: rect.size.height)
        self.eeeee.addFlicker()
        return
        
        
        
        let ps = ZLPhotoPreviewSheet()
        ZLPhotoConfiguration.default().maxSelectCount = 4
        ps.selectImageBlock = { [weak self] results, isOriginal in
            // your code
        }
        ps.showPhotoLibrary(sender: self)
    }
    
    // MARK: - Animation
    
    func animateText() {
        animationTimer?.invalidate()
        configureLabel(alpha: 0, until: typingLabel.text?.count)
        
        var showCharactersUntilIndex = 1
        
        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] (timer: Timer) in
            if let label = self?.typingLabel, let attributedText = label.attributedText {
//                let characters = Array(attributedText.string.characters)
                
                if showCharactersUntilIndex <= attributedText.string.count {
                    self?.configureLabel(alpha: 1, until: showCharactersUntilIndex)
                    
                    showCharactersUntilIndex += 1
                } else {
                    timer.invalidate()
                }
            } else {
                timer.invalidate()
            }
        })
    }
    
    func configureLabel(alpha: CGFloat, until: Int?) {
        if let attributedText = typingLabel.attributedText  {
            let attributedString = NSMutableAttributedString(attributedString: attributedText)
            attributedString.addAttribute(.foregroundColor, value: typingLabel.textColor.withAlphaComponent(CGFloat(alpha)), range: NSMakeRange(0, until ?? 0))
            typingLabel.attributedText = attributedString
        }
    }
}

