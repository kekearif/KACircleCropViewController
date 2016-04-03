//
//  KACircleCropViewController.swift
//  Circle Crop View Controller
//
//  Created by Keke Arif on 29/02/2016.
//  Copyright © 2016 Keke Arif. All rights reserved.
//

import UIKit

protocol KACircleCropViewControllerDelegate
{
    
    func circleCropDidCancel()
    func circleCropDidCropImage(image: UIImage)
    
}

class KACircleCropViewController: UIViewController, UIScrollViewDelegate {
    
    var delegate: KACircleCropViewControllerDelegate?
    
    var image: UIImage
    let imageView = UIImageView()
    let scrollView = KACircleCropScrollView(frame: CGRect(x: 0, y: 0, width: 240, height: 240))
    let cutterView = KACircleCropCutterView()
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 130, height: 30))
    let okButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
    let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
    
    
    init(withImage image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: View management
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        scrollView.backgroundColor = UIColor.blackColor()
        
        imageView.image = image
        imageView.frame = CGRect(origin: CGPointZero, size: image.size)
        scrollView.delegate = self
        scrollView.addSubview(imageView)
        scrollView.contentSize = image.size
        
        let scaleWidth = scrollView.frame.size.width / scrollView.contentSize.width
        scrollView.minimumZoomScale = scaleWidth
        if imageView.frame.size.width < scrollView.frame.size.width {
            print("We have the case where the frame is too small")
            scrollView.maximumZoomScale = scaleWidth * 2
        } else {
            scrollView.maximumZoomScale = 1.0
        }
        scrollView.zoomScale = scaleWidth
        
        //Center vertically
        scrollView.contentOffset = CGPoint(x: 0, y: (scrollView.contentSize.height - scrollView.frame.size.height)/2)
        
        //Add in the black view. Note we make a square with some extra space +100 pts to fully cover the photo when rotated
        cutterView.frame = view.frame
        cutterView.frame.size.height += 100
        //Test this
        //cutterView.frame.size.width = cutterView.frame.size.height + 100
        cutterView.frame.size.width = cutterView.frame.size.height
        
        //Add the label and buttons
        label.text = "Move and Scale"
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.font = label.font.fontWithSize(17)
        
        okButton.setTitle("OK", forState: .Normal)
        okButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        okButton.titleLabel?.font = backButton.titleLabel?.font.fontWithSize(17)
        okButton.addTarget(self, action: "didTapOk", forControlEvents: .TouchUpInside)
        
        backButton.setTitle("<", forState: .Normal)
        backButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        backButton.titleLabel?.font = backButton.titleLabel?.font.fontWithSize(30)
        backButton.addTarget(self, action: "didTapBack", forControlEvents: .TouchUpInside)
        
        setLabelAndButtonFrames()
        
        view.addSubview(scrollView)
        view.addSubview(cutterView)
        cutterView.addSubview(label)
        cutterView.addSubview(okButton)
        cutterView.addSubview(backButton)
        
        
    }
    
    
    func setLabelAndButtonFrames() {
        
        scrollView.center = view.center
        cutterView.center = view.center
        
        label.frame.origin = CGPoint(x: cutterView.frame.size.width/2 - label.frame.size.width/2, y: cutterView.frame.size.height/2 - view.frame.size.height/2 + 3)
        
        okButton.frame.origin = CGPoint(x: cutterView.frame.size.width/2 + view.frame.size.width/2 - okButton.frame.size.width - 12, y: cutterView.frame.size.height/2 - view.frame.size.height/2 + 3)
        
        backButton.frame.origin = CGPoint(x: cutterView.frame.size.width/2 - view.frame.size.width/2 + 3, y: cutterView.frame.size.height/2 - view.frame.size.height/2 + 1)
        
    }
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        
        coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            self.setLabelAndButtonFrames()
            
            }) { (UIViewControllerTransitionCoordinatorContext) -> Void in
        }
        
        
    }
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    // MARK: Button taps
    
    func didTapOk() {
        

        let newSize = CGSize(width: image.size.width*scrollView.zoomScale, height: image.size.height*scrollView.zoomScale)
        
        let offset = scrollView.contentOffset
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 240, height: 240), false, 0)
        let circlePath = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: 240, height: 240))
        circlePath.addClip()
        var sharpRect = CGRect(x: -offset.x, y: -offset.y, width: newSize.width, height: newSize.height)
        sharpRect = CGRectIntegral(sharpRect)
        
        image.drawInRect(sharpRect)
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let imageData = UIImagePNGRepresentation(finalImage) {
            if let pngImage = UIImage(data: imageData) {
                delegate?.circleCropDidCropImage(pngImage)
            } else {
                delegate?.circleCropDidCancel()
            }
        } else {
            delegate?.circleCropDidCancel()
        }
        
        
        
    }
    
    func didTapBack() {
        
        delegate?.circleCropDidCancel()
        
    }
    

}
