//
//  CreateMemeVC.swift
//  MemeMe 2.0
//
//  Created by Nafisur Ahmed on 20/12/17.
//  Copyright © 2017 Nafisur Ahmed. All rights reserved.
//

import UIKit

class CreateMemeVC: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    //IBOutlets
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var memeImgView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
   
        topTextField.autocapitalizationType = .allCharacters
        bottomTextField.autocapitalizationType = .allCharacters
        topTextField.backgroundColor = UIColor.clear
        bottomTextField.backgroundColor = UIColor.clear
        memeImgView.contentMode = .scaleAspectFit //image should be aspect fit
        shareButton.isEnabled = false //disabled until an image is chosen
    
        let memeTextAttributes: [String:Any] = [
            NSAttributedStringKey.strokeColor.rawValue : UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue : UIColor.white,
            NSAttributedStringKey.font.rawValue : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue : -4.0
        ]
        
       topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
    
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        if !(UIImagePickerController.isSourceTypeAvailable(.camera)) { //check if camera is not available //simulator
            
            cameraButton.isEnabled = false
        }
        NotificationCenter.default.addObserver(self, selector: #selector(CreateMemeVC.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CreateMemeVC.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }//viewDidLoad Ends here
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -(keyboardHeight(notification))
        }
        
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
    }
    
    func keyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func chooseImageFrom(source: UIImagePickerControllerSourceType) {
       
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func albumButtonTapped(_ sender: Any) {
      
        chooseImageFrom(source: .photoLibrary)
     
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        
       chooseImageFrom(source: .camera)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        memeImgView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        shareButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM"{
            textField.text = ""
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func setupBars(hidden : Bool){
        
        navBar.isHidden = hidden
        toolBar.isHidden = hidden
        
    }
    func generateMemedImage() -> UIImage {
        
       setupBars(hidden: true)
   
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
   
        setupBars(hidden: false)
        
        return memedImage
    }
    
    func save() {
        
        let memedImage = generateMemedImage()
        let newMeme = Meme(top: topTextField.text!, bottom: bottomTextField.text!, image: memeImgView.image, memedImage: memedImage)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(newMeme)
        
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        
        let memedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityController.completionWithItemsHandler = { activity, success, items, error in
            
            if success {
            self.save()
            }
            
            self.dismiss(animated: true, completion: nil)
        }
        
        present(activityController, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
      
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        memeImgView.image = nil
        shareButton.isEnabled = false
    }
    
}

