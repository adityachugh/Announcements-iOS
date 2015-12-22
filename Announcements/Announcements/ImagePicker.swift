//
//  ImagePicker.swift
//  infor[me]
//
//  Created by Aditya Chugh on 12/21/15.
//  Copyright © 2015 Mindbend Studio. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary

class ImagePicker: NSObject, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var presentingViewController: UIViewController!
    var completion: (UIImage?)->()!
    var cameraActionSheet: UIActionSheet!
    
    init(presentingViewController: UIViewController, completion:(UIImage?)->()) {
        self.presentingViewController = presentingViewController
        self.completion = completion
    }
    
    func setup() {
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                alertController.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: {
                    (alertAction) -> Void in
                    self.presentPickerViewController(UIImagePickerControllerSourceType.Camera)
                }))
            }
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                alertController.addAction(UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default, handler: {
                    (alertAction) -> Void in
                    self.presentPickerViewController(UIImagePickerControllerSourceType.PhotoLibrary)
                }))
            }
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
                (alertAction) -> Void in
                
            }))
            
            alertController.modalPresentationStyle = UIModalPresentationStyle.Popover
            alertController.popoverPresentationController?.barButtonItem = presentingViewController.navigationItem.rightBarButtonItem
            
            presentingViewController.presentViewController(alertController, animated: true) { () -> Void in }
            
        } else {
            cameraActionSheet = UIActionSheet()
            var index = 0
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                cameraActionSheet!.addButtonWithTitle("Camera")
                ++index
            }
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                cameraActionSheet!.addButtonWithTitle("Photo Library")
                ++index
            }
            cameraActionSheet!.addButtonWithTitle("Cancel")
            cameraActionSheet!.cancelButtonIndex = index
            cameraActionSheet!.delegate = self
            
            cameraActionSheet!.showFromBarButtonItem(presentingViewController.navigationItem.rightBarButtonItem!, animated: true)
        }

    }
    
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if actionSheet == cameraActionSheet {
            switch buttonIndex {
            case 0:
                presentPickerViewController(UIImagePickerControllerSourceType.Camera)
            case 1:
                presentPickerViewController(UIImagePickerControllerSourceType.SavedPhotosAlbum)
            default:
                fatalError()
            }
        }
    }
    
    func actionSheetCancel(actionSheet: UIActionSheet) {
        completion(nil)
    }
    
    func presentPickerViewController(sourceType: UIImagePickerControllerSourceType) {
        let cameraRollStatus = ALAssetsLibrary.authorizationStatus()
        let cameraStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        
        if sourceType == UIImagePickerControllerSourceType.Camera {
            if !(cameraStatus == AVAuthorizationStatus.Denied) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = sourceType
                
                presentingViewController.presentViewController(imagePicker, animated: true, completion: { () -> Void in })
            } else {
                if Utilities.iOS8 {
                    presentAlertView("Error", body: "infor[me] does not have permission to use the Camera. You can give infor[me] permission by going to Settings > infor[me] > Camera.")
                } else {
                    presentAlertView("Error", body: "infor[me] does not have permission to use the Camera. You can give infor[me] permission by going to Settings > Privacy > Camera > infor[me].")
                }
            }
        } else {
            if !(cameraRollStatus == ALAuthorizationStatus.Denied) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = sourceType
                
                presentingViewController.presentViewController(imagePicker, animated: true, completion: { () -> Void in })
            } else {
                if #available(iOS 8.0, *) {
                    presentAlertView("Error", body: "infor[me] does not have permission to access Photos. You can give infor[me] permission by going to Settings > infor[me] > Photos.")
                } else {
                    presentAlertView("Error", body: "infor[me] does not have permission to access Photos. You can give infor[me] permission by going to Settings > Privacy > Photos > infor[me].")
                }
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        completion(image)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func presentAlertView(title: String, body: String) {
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: title, message: body, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: {
                (alertAction) -> Void in
            }))
            presentingViewController.presentViewController(alertController, animated: true) { () -> Void in }
        } else {
            let alertView = UIAlertView(title: title, message: body, delegate: nil, cancelButtonTitle: "Okay")
            alertView.show()
        }
    }
}