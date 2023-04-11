//
//  CACreationController.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/4/9.
//

import UIKit

class CACreationController: CABaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var typingLabel: UILabel!
    
    var animationTimer: Timer?
    
    // MARK: - ViewLifecycle
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animationTimer?.invalidate()
    }
    
    // MARK: - ButtonActions
    
    @IBAction func animatorButtonPressed(_ sender: Any) {
        animateText()
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

