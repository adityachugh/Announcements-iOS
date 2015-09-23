//
//  UserViewController.swift
//  infor[me]
//
//  Created by Aditya Chugh on 8/20/15.
//  Copyright (c) 2015 Mindbend Studio. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary

class UserViewController: UIViewController, CollectionViewRefreshDelegate, ScrollingDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, RSKImageCropViewControllerDelegate, TextViewControllerDelegate {
    
    @IBOutlet weak var userCoverPhotoImageView: PFImageView!
    @IBOutlet weak var userProfilePictureImageView: PFImageView!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var organizationsCountLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var organizationCollectionViewManager: OrganizationCollectionViewManager!
    @IBOutlet weak var userViewTopConstraint: NSLayoutConstraint!
    var cameraActionSheet: UIActionSheet?
    var user: User!
    var currentAction = Action.None
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if user == nil {
            user = User.currentUser()
        }
        organizationCollectionViewManager = OrganizationCollectionViewManager(collectionView: collectionView, parentViewController: self, refreshDelegate: self)
        organizationCollectionViewManager.scrollingDelegate = self
        setupUser()
        addEditButton()
    }
    
    func setupUser() {
        if let profilePhotoFile = user.profilePhoto {
            userProfilePictureImageView.file = profilePhotoFile
            userProfilePictureImageView.loadInBackground({ (image, error) -> Void in })
        }
        if let coverPhotoFile = user.coverPhoto {
            userCoverPhotoImageView.file = coverPhotoFile
            userCoverPhotoImageView.loadInBackground({ (image, error) -> Void in })
        }
        
        navigationItem.title = "\(user.firstName) \(user.lastName)"
        userProfilePictureImageView.layer.cornerRadius = userProfilePictureImageView.frame.size.height / 2
        userProfilePictureImageView.layer.masksToBounds = true
        userHandleLabel.text = "@\(user.username!)"
        organizationsCountLabel.text = "\(user.organizationsFollowedCount) Organizations"
    }
    
    func addEditButton() {
        if PFUser.currentUser()?.objectId == user.objectId {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: "editButtonTapped")
        }
    }
    
    func editButtonTapped() {
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: "Edit Profile", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            alertController.addAction(UIAlertAction(title: "Change Profile Photo", style: UIAlertActionStyle.Default, handler: {
                (alertAction) -> Void in
                self.changeProfilePhoto()
            }))
            
            alertController.addAction(UIAlertAction(title: "Change Cover Photo", style: UIAlertActionStyle.Default, handler: {
                (alertAction) -> Void in
                self.changeCoverPhoto()
            }))
            
            alertController.addAction(UIAlertAction(title: "Edit Description", style: UIAlertActionStyle.Default, handler: {
                (alertAction) -> Void in
                self.editDescription()
            }))
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
                (alertAction) -> Void in
                
            }))
            alertController.modalPresentationStyle = UIModalPresentationStyle.Popover
            alertController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            self.presentViewController(alertController, animated: true) { () -> Void in }
        } else {
            let actionSheet = UIActionSheet()
            actionSheet.addButtonWithTitle("Change Profile Photo")
            actionSheet.addButtonWithTitle("Change Cover Photo")
            actionSheet.addButtonWithTitle("Edit Description")
            actionSheet.addButtonWithTitle("Cancel")
            actionSheet.cancelButtonIndex = 3
            actionSheet.delegate = self
            
            actionSheet.showFromBarButtonItem(navigationItem.rightBarButtonItem!, animated: true)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        if currentAction == Action.ProfilePicture {
            let cropViewController = RSKImageCropViewController(image: image)
            cropViewController.delegate = self
            cropViewController.rotationEnabled = true
            picker.pushViewController(cropViewController, animated: true)
        } else {
            let data = compressImage(100, minFileSizeInKilobytes: 40, image: image)
            if let imageData = data {
                print("Ended Compressing")
                let parameters: Dictionary = ["userObjectId": PFUser.currentUser()!.objectId!, "photo": imageData] as [NSObject : AnyObject]
                print("Started Save!")
                PFCloud.callFunctionInBackground("updateUserCoverPhoto", withParameters: parameters, block: {
                    (result, error) -> Void in
                    picker.dismissViewControllerAnimated(true, completion: nil)
                    if let user = result as? PFUser {
                        print("Saved!")
                        self.userCoverPhotoImageView.image = image
                    }
                })
                currentAction = Action.None
            } else {
                currentAction = Action.None
                
                picker.dismissViewControllerAnimated(true, completion: nil)
                presentAlertView("Error", body: "The selected image is too large, please choose a smaller image and try again.", rootViewController: self)
            }
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imageCropViewControllerDidCancelCrop(controller: RSKImageCropViewController!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func compressImage(maxFileSizeInKilobytes:Int, minFileSizeInKilobytes: Int, image:UIImage) -> NSData? {
        var data = UIImageJPEGRepresentation(image, 1)
        var currentImage = image
        let maxFileSize = maxFileSizeInKilobytes*1024
        let minFileSize = minFileSizeInKilobytes*1024
        
        if data?.length < maxFileSize {
            return data
        }
        
        var high = 1.0
        var low = 0.0
        
        let start = NSDate()
        while low <= high {
            let mid = (high+low)/2.0
            currentImage = image.resize(CGFloat(mid))
            data = UIImageJPEGRepresentation(currentImage, 1)
            if data?.length < maxFileSize && data?.length > minFileSize {
                let end = NSDate()
                let duration = end.timeIntervalSince1970 - start.timeIntervalSince1970
                print("Duration: \(duration)s")
                return data
            }
            if data?.length > maxFileSize {
                high = mid
            }
            if data?.length < minFileSize {
                low = mid
            }
        }
        return nil
    }
    
    func imageCropViewController(controller: RSKImageCropViewController!, didCropImage croppedImage: UIImage!, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {
        
        let data = compressImage(50, minFileSizeInKilobytes: 20, image: croppedImage)
        if let imageData = data {
            print("Ended Compressing")
            let parameters: Dictionary = ["userObjectId": PFUser.currentUser()!.objectId!, "photo": imageData] as [NSObject : AnyObject]
            print("Started Save!")
            PFCloud.callFunctionInBackground("updateUserProfilePhoto", withParameters: parameters, block: {
                (result, error) -> Void in
                controller.dismissViewControllerAnimated(true, completion: nil)
                if let user = result as? PFUser {
                    print("Saved!")
                    self.userProfilePictureImageView.image = croppedImage
                }
            })
            currentAction = Action.None
            
            controller.dismissViewControllerAnimated(true, completion: nil)
        } else {
            currentAction = Action.None
            
            controller.dismissViewControllerAnimated(true, completion: nil)
            presentAlertView("Error", body: "The selected image is too large, please choose a smaller image and try again.", rootViewController: self)
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
                let i = 0
            }
        }
        else {
            switch buttonIndex {
            case 0:
                changeProfilePhoto()
            case 1:
                changeCoverPhoto()
            case 2:
                editDescription()
            default:
                let i = 0
            }
        }
    }
    
    func changeProfilePhoto() {
        selectPhoto(Action.ProfilePicture)
    }
    
    func selectPhoto(action: Action) {
        currentAction = action
        
//        if objc_getClass("UIAlertController") != nil {
        
            
            if #available(iOS 8.0, *) {
                var alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
                
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
                alertController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
                
                self.presentViewController(alertController, animated: true) { () -> Void in }
                
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
                
                cameraActionSheet!.showFromBarButtonItem(navigationItem.rightBarButtonItem!, animated: true)
            }
        

//        } else {
//            
//        }
    }
    
    func presentPickerViewController(sourceType: UIImagePickerControllerSourceType) {
        let cameraRollStatus = ALAssetsLibrary.authorizationStatus()
        let cameraStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        
        if sourceType == UIImagePickerControllerSourceType.Camera {
            if !(cameraStatus == AVAuthorizationStatus.Denied) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = sourceType
                
                self.presentViewController(imagePicker, animated: true, completion: { () -> Void in })
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
                
                self.presentViewController(imagePicker, animated: true, completion: { () -> Void in })
            } else {
                if Utilities.iOS8 {
                    presentAlertView("Error", body: "infor[me] does not have permission to access Photos. You can give infor[me] permission by going to Settings > infor[me] > Photos.")
                } else {
                    presentAlertView("Error", body: "infor[me] does not have permission to access Photos. You can give infor[me] permission by going to Settings > Privacy > Photos > infor[me].")
                }
            }
        }
    }
    
    func presentAlertView(title: String, body: String) {
        presentAlertView(title, body: body, rootViewController: self)
    }
    
    func presentAlertView(title: String, body: String, rootViewController: UIViewController) {
//        if objc_getClass("UIAlertController") != nil {
            if #available(iOS 8.0, *) {
                let alertController = UIAlertController(title: title, message: body, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: {
                    (alertAction) -> Void in
                }))
                rootViewController.presentViewController(alertController, animated: true) { () -> Void in }
            } else {
                let alertView = UIAlertView(title: title, message: body, delegate: nil, cancelButtonTitle: "Okay")
                alertView.show()
            }
//        } else {
//            
//
//        }
    }
    
    func changeCoverPhoto() {
        selectPhoto(Action.CoverPhoto)
    }
    
    func editDescription() {
        Utilities.presentViewControllerModallyVithStoryboardIdentifier("TextViewController", parentViewController: self) {
            (toViewController) -> UIViewController in
            let viewController = toViewController as! TextViewController
            viewController.delegate = self
            viewController.maxCharacterCount = 50
            return viewController
        }
    }
    
    func didCancelTextEntry(viewController: TextViewController) {
        Utilities.animateWithCompletion({
            () -> () in
            viewController.hide()
            }, completion: {
                () -> () in
                viewController.dismissViewControllerAnimated(false, completion: nil)
        })
    }
    
    func didEnterText(viewController: TextViewController, text: String) {
        viewController.shouldShowActivityIndicator = true
        let parameters = ["userObjectId": user.objectId!, "description": text] as [NSObject: AnyObject]
        PFCloud.callFunctionInBackground("updateUserDescription", withParameters: parameters) {
            (results, error) -> Void in
            
            viewController.shouldShowActivityIndicator = false
            Utilities.animateWithCompletion({
                () -> () in
                viewController.hide()
                }, completion: {
                    () -> () in
                    viewController.dismissViewControllerAnimated(false, completion: nil)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func refreshData(refreshControl: UIRefreshControl, collectionView: UICollectionView) {
        let parameters: Dictionary = ["startIndex": 0, "numberOfOrganizations": 10, "userObjectId": user.objectId!]  as [NSObject : AnyObject]
        PFCloud.callFunctionInBackground("getOrganizationsFollowedByUserInRange", withParameters: parameters) {
            (results, error) -> Void in
            if let organizations = results as? [Follower] {
                self.organizationCollectionViewManager.data = []
                for result in results as! [Follower] {
                    self.organizationCollectionViewManager.data.append(result.organization)
                }
            }
            collectionView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    func addData(refreshControl: UIRefreshControl, collectionView: UICollectionView, startIndex: Int, numberOfOrganizations: Int) {
        let parameters: Dictionary = ["startIndex": startIndex, "numberOfOrganizations": numberOfOrganizations, "userObjectId": user.objectId!]  as [NSObject : AnyObject]
        PFCloud.callFunctionInBackground("getOrganizationsFollowedByUserInRange", withParameters: parameters) {
            (results, error) -> Void in
            if results != nil {
                for result in results as! [Follower] {
                    self.organizationCollectionViewManager.data.append(result.organization)
                }
            }
            collectionView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    func didScroll(scrollView: UIScrollView) {
//        let contentOffset = scrollView.contentOffset.y
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

enum Action {
    case ProfilePicture
    case CoverPhoto
    case Description
    case None
}