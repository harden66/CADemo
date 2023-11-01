//
//  CASelectPhotoController.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/4/23.
//

import UIKit
import Photos

class CASelectPhotoController: CABaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 240, height: 240))
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc func clickBtn() {
        self.selectImagesButtonTapped()
    }
    
    func selectImagesButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        imagePickerController.mediaTypes = ["public.image"]
        imagePickerController.modalPresentationStyle = .fullScreen
        imagePickerController.navigationBar.tintColor = UIColor.white
        imagePickerController.navigationBar.barTintColor = UIColor.black
        imagePickerController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        imagePickerController.navigationBar.isTranslucent = false
        imagePickerController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
//        imagePickerController.allowsMultipleSelection = true
//        imagePickerController.maxNumberOfImages = 4 // 最多可以选择4张图片
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImages = info[UIImagePickerController.InfoKey.phAsset] as? [PHAsset] else {
            return
        }
        
        // 对选择的图片进行处理
        // ...
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }


}
