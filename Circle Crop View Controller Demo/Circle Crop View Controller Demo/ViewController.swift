//
//  ViewController.swift
//  Circle Crop View Controller Demo
//
//  Created by Keke Arif on 04/04/2016.
//  Copyright © 2016 Keke Arif. All rights reserved.
//

import UIKit

class ViewController: UIViewController, KACircleCropViewControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    var firstLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if firstLoad {
            
            let circleCropController = KACircleCropViewController(withImage: UIImage(named: "cloud.jpg")!)
            circleCropController.delegate = self
            present(circleCropController, animated: false, completion: nil)
            
            firstLoad = false
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:  KACircleCropViewControllerDelegate methods
    
    func circleCropDidCancel() {
        //Basic dismiss
        dismiss(animated: false, completion: nil)
    }
    
    func circleCropDidCropImage(_ image: UIImage) {
        //Same as dismiss but we also return the image
        imageView.image = image
        dismiss(animated: false, completion: nil)
    }



}

