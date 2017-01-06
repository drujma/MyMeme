//
//  CollectionViewController.swift
//  Meme
//
//  Created by Fabrizio De Stefani on 06/01/2017.
//  Copyright © 2017 udacity. All rights reserved.
//

import UIKit


class CollectionViewController : UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var memes : [Meme]!
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(CollectionViewController.addMeme))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memes = appDelegate.memes
        self.collectionView!.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let meme = memes[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellView", for: indexPath) as! CellView
        cell.imageView.image = meme.editedImage
        
        return cell
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            let memeController = self.storyboard!.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
            
            memeController.pickedImage = pickedImage
            self.navigationController?.pushViewController(memeController, animated: true)
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func addMeme() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
}
