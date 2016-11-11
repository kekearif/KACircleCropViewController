# KACircleCropViewController
An extremely simple circular crop view controller created in Swift, similar in style to the crop controller that Line uses.

# Usage
<img src="https://github.com/kekearif/KACircleCropViewController/blob/master/Circle%20Crop%20View%20Controller%20Demo/screenshot.png?raw=true" alt="Circle Crop View Controller" align="right">
Drag the files *KACircleCropViewController*, *KACircleCropScrollView* and *KACircleCropCutterView* into your project. Initialize the view controller, pass in the image to be cropped, and then present.
```Swift
let circleCropController = KACircleCropViewController(withImage: UIImage(named: "cloud.jpg")!)
circleCropController.delegate = self
presentViewController(circleCropController, animated: false, completion: nil)
```
Make the presenting view controller conform to the KACircleCropViewControllerDelegate protocol and implement its methods.
```Swift
 func circleCropDidCancel() {
        //Basic dismiss
        dismissViewControllerAnimated(false, completion: nil)
    }
    
func circleCropDidCropImage(image: UIImage) {
     //Same as dismiss but we also return the image
     imageView.image = image
     dismissViewControllerAnimated(false, completion: nil)
    }
```
A demo project can be found in the repository.

#Requirements
Swift 3

#License
KACircleCropViewController is licensed under the MIT License, please see the [LICENSE](LICENSE.md) file. Pull requests and contributions always welcome :smiley:




