//
//  Meme.swift
//  Meme
//
//  Created by Fabrizio De Stefani on 26/12/2016.
//  Copyright © 2016 udacity. All rights reserved.
//

import UIKit

class Meme {
    var originalImage : UIImage
    var editedImage : UIImage
    var top : String
    var bottom : String
    
    init(originalImage : UIImage, editedImage : UIImage, top : String, bottom : String){
        self.originalImage = originalImage
        self.editedImage = editedImage
        self.top = top
        self.bottom = bottom
    }
}
