//
//  MemeViewController.swift
//  Meme
//
//  Created by Fabrizio De Stefani on 26/12/2016.
//  Copyright © 2016 udacity. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {
    
    @IBOutlet weak var top: UITextField!
    @IBOutlet weak var bottom: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var pickedImage : UIImage?
    
    let topDelegate = TextFieldDelegate("top")
    let bottomDelegate = TextFieldDelegate("bottom")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memeTextAttributes:[String:Any] = [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 35)!,
            NSStrokeWidthAttributeName: 2.0]
        
        self.top.defaultTextAttributes = memeTextAttributes
        self.top.delegate = topDelegate
        
        self.bottom.defaultTextAttributes = memeTextAttributes
        self.bottom.delegate = bottomDelegate
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(MemeViewController.keyboardShown(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MemeViewController.keyboarHidden(_:)), name: .UIKeyboardWillHide, object: nil)
        
        self.tabBarController!.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let pickedImage = self.pickedImage {
            imageView.image = pickedImage
        }
        
        self.top.text = "TOP"
        self.bottom.text = "BOTTOM"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        
        self.tabBarController!.tabBar.isHidden = false
    }

    @IBAction func shareMeme(_ sender: Any) {
        if let image = self.imageView.image {
            let memeImage = generateMemeImage()
            let activityController = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
            
            activityController.completionWithItemsHandler = { activity, success, items, error in
                
                if success {
                    let meme = Meme(originalImage: image, editedImage: memeImage, top: self.top.text!, bottom: self.bottom.text!)
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.memes.append(meme)
                    
                    self.navigationController!.popViewController(animated: true)
                }
            }
            
            
            self.present(activityController, animated: true, completion: nil)
        }else{
            print("Image is nil")
        }
    }

    func generateMemeImage() -> UIImage{
        if let tabBar = self.tabBarController?.tabBar{
            tabBar.isHidden = true
        }
        
        if let navigationBar = self.navigationController?.navigationBar{
            navigationBar.isHidden = true
        }
        
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let memeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        if let tabBar = self.tabBarController?.tabBar{
            tabBar.isHidden = false
        }
        
        if let navigationBar = self.navigationController?.navigationBar{
            navigationBar.isHidden = false
        }
        
        return memeImage!
    }
    
    func keyboardShown(_ notification : Notification){
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue
        if let keyboardSize = keyboardSize?.cgRectValue.height {
            self.view.frame.origin.y = 0 - keyboardSize
        }else{
            print("Something went wrong converting keyboard size")
        }
    }
    
    func keyboarHidden(_ notification : Notification){
        self.view.frame.origin.y = 0
    }
}

