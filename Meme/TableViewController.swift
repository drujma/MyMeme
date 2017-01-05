//
//  MainViewController.swift
//  Meme
//
//  Created by Fabrizio De Stefani on 26/12/2016.
//  Copyright © 2016 udacity. All rights reserved.
//

import UIKit

class TableViewController : UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    var memes : [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(TableViewController.addMeme))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memes = appDelegate.memes
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCellView")!
        
        cell.imageView?.image = self.memes[(indexPath as NSIndexPath).row].editedImage
        
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
