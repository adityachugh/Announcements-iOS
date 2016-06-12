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
    var completion: (UIImage?, UIImagePickerController?)->()!
    var cameraActionSheet: UIActionSheet!
    var presentationBarButtonItem: UIBarButtonItem?
    let imagePickerController = UIImagePickerController()
    
    init(presentingViewController: UIViewController, presentationBarButtonItem: UIBarButtonItem?, completion:(UIImage?, UIImagePickerController?)->()) {
        self.presentingViewController = presentingViewController
        self.presentationBarButtonItem = presentationBarButtonItem
        self.completion = completion
        super.init()
    }
    
    func show() {
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
            if let presentationBarButtonItem = presentationBarButtonItem {
                alertController.popoverPresentationController?.barButtonItem = presentationBarButtonItem
            }
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
            
            if let presentationBarButtonItem = presentationBarButtonItem {
                cameraActionSheet!.showFromBarButtonItem(presentationBarButtonItem, animated: true)
            } else {
                cameraActionSheet.showInView(presentingViewController.view)
            }
        }

    }
    
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        print("Tapped")
        if actionSheet == cameraActionSheet {
            switch buttonIndex {
            case 0:
                presentPickerViewController(UIImagePickerControllerSourceType.Camera)
            case 1:
                presentPickerViewController(UIImagePickerControllerSourceType.SavedPhotosAlbum)
            default:
                _ = 0
            }
        }
    }
    
    func actionSheetCancel(actionSheet: UIActionSheet) {
        completion(nil, nil)
    }
    
    func presentPickerViewController(sourceType: UIImagePickerControllerSourceType) {
        let cameraRollStatus = ALAssetsLibrary.authorizationStatus()
        let cameraStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        
        if sourceType == UIImagePickerControllerSourceType.Camera && (cameraStatus == AVAuthorizationStatus.Denied) {
            presentAlertView("Error", body: "infor[me] does not have permission to use the Camera. You can give infor[me] permission by going to Settings > Privacy > Camera > infor[me].")
        } else if cameraRollStatus == ALAuthorizationStatus.Denied {
            presentAlertView("Error", body: "infor[me] does not have permission to access your Photos. You can give infor[me] permission by going to Settings > infor[me] > Photos.")
        } else {
            print("Presenting ImagePicker")
            self.presentingViewController.presentViewController(self.imagePickerController, animated: true, completion: { () -> Void in })
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        completion(image, picker)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        completion(nil, nil)
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