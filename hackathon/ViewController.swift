//
//  ViewController.swift
//  hackathon
//
//  Created by 엄태형 on 2018. 7. 20..
//  Copyright © 2018년 엄태형. All rights reserved.
//

import MobileCoreServices
import UIKit

import FlexibleImage

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    let imagePickerController = UIImagePickerController()
    var selectedImage = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
    }
    
    // Camera iCON Button Setting
    
    @IBAction func cameraClick(_ sender: Any) {
        let choiceOptionAlertController = UIAlertController(
            title: "메뉴를 선택하세요",
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let takePhotoAction = UIAlertAction(title: "사진 촬영", style: .default) { _ in
            print("takePhotoAction")
            
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
            self.imagePickerController.sourceType = .camera
            self.imagePickerController.allowsEditing = false
            
            self.present(self.imagePickerController, animated: true)
        }
        
        let openGalleryAction = UIAlertAction(title: "갤러리에서 가져오기", style: .default) { _ in
            print("openAlbumAction")
            
            let type = UIImagePickerControllerSourceType.photoLibrary
            guard UIImagePickerController.isSourceTypeAvailable(type) else { return }
            
            self.imagePickerController.sourceType = type
            self.present(self.imagePickerController, animated: true)
            
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("cancelAction")
            
            
        }
        
        choiceOptionAlertController.addAction(takePhotoAction)
        choiceOptionAlertController.addAction(openGalleryAction)
        choiceOptionAlertController.addAction(cancelAction)
        
        present(choiceOptionAlertController, animated: true)
    }
    
    
    // First filter Setting
    
    @IBAction func filter1Click(_ sender: Any) {
        print("Click filter1")
        guard imageView.image != nil else { return }
        let warmFilter = selectedImage.adjust()
            .exclusion(color: UIColor(red: 0, green: 0, blue: 0.352941176, alpha: 1.0))
            .image()
        imageView.image = warmFilter
        
    }
    
    // Second filter Setting
    
    @IBAction func filter2Click(_ sender: Any) {
        print("Click filter2")
        guard imageView.image != nil else { return }
        let firstFilter = selectedImage.adjust()
            .exclusion(color: UIColor(red: 0, green: 0, blue: 0.352941176, alpha: 1))
            .linearDodge(color: UIColor(red: 0.125490196, green: 0.058823529, blue: 0.192156863, alpha: 1.0))
            .image()
        imageView.image = firstFilter
    }
    
    // Third filter Setting
    
    @IBAction func filter3Click(_ sender: Any) {
        print("Click filter3")
        guard imageView.image != nil else { return }
        let firstFilter = selectedImage.adjust()
            .exclusion(color: UIColor(red: 0, green: 0, blue: 0.352941176, alpha: 1))
            .linearDodge(color: UIColor(red: 0.125490196, green: 0.058823529, blue: 0.192156863, alpha: 1.0))
            .hardMix(color: UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0))
            .image()
        imageView.image = firstFilter
    }
    
    // Fourth filter Setting
    
    @IBAction func filter4Click(_ sender: Any) {
        print("Click filter4")
        guard imageView.image != nil else { return }
        let vividFilter = selectedImage.adjust()
//            .exclusion(color: UIColor(red: 0, green: 0.152941176, blue: 0, alpha: 1.0))
            .vibrance(1.0)
            .image()
        imageView.image = vividFilter
    }
    
    @IBAction func saveClick(_ sender: Any) {
    }
    
}


// MARK: - UIImagePickerControllerDelegate

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("\n---------- [ didFinishPickingMediaWithInfo ] ----------\n")
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        if UTTypeEqual(mediaType, kUTTypeMovie) {
            let url = info[UIImagePickerControllerMediaURL] as! NSURL
            if let path = url.path {
                UISaveVideoAtPathToSavedPhotosAlbum(path, nil, nil, nil)
            }
        } else {
            let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
            selectedImage = editedImage ?? originalImage!
            imageView.image = selectedImage

        }
        
        picker.dismiss(animated: true)
    }
    
    /***************************************************
     // 앨범에 이미지 저장
     UIImageWriteToSavedPhotosAlbum(<#T##image: UIImage##UIImage#>, <#T##completionTarget: Any?##Any?#>, <#T##completionSelector: Selector?##Selector?#>, <#T##contextInfo: UnsafeMutableRawPointer?##UnsafeMutableRawPointer?#>)
     
     // 앨범에 비디오 저장
     UISaveVideoAtPathToSavedPhotosAlbum(<#T##videoPath: String##String#>, <#T##completionTarget: Any?##Any?#>, <#T##completionSelector: Selector?##Selector?#>, <#T##contextInfo: UnsafeMutableRawPointer?##UnsafeMutableRawPointer?#>)
     ***************************************************/
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("\n---------- [ imagePickerControllerDidCancel ] ----------\n")
        picker.dismiss(animated: true)
    }
}

