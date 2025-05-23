//
//  ProfiledetailsVC.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 23/05/25.
//

import UIKit
import CoreData
import Photos

protocol ProfileImageDelegate: AnyObject {
    func didSelectProfileImage(_ image: UIImage)
}


class ProfiledetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileImgView: UIView!
    @IBOutlet weak var userPhonNotxt: UITextField!
    @IBOutlet weak var userGendartxt: UITextField!
    @IBOutlet weak var userMailIdtxt: UITextField!
    @IBOutlet weak var userNametxt: UITextField!
    @IBOutlet weak var addbtn: UIButton!
    var isEditMode :Bool = false
    var exitingData :UserDetails?
    weak var delegate: ProfileImageDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isEditMode{
            userNametxt.text = exitingData?.userName
            userGendartxt.text = exitingData?.userGendar
            userMailIdtxt.text = exitingData?.userEmailid
            userPhonNotxt.text = exitingData?.userPhoneNo
            addbtn.setTitle("Edit Profile", for: .normal)
        }
        profileImgView.layer.cornerRadius = profileImgView.frame.height / 2
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.clipsToBounds = true
        
        if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
           let savedImage = UIImage(data: imageData) {
           profileImg.image = savedImage
        }
    }
    
    @IBAction func pickImgBtn(_ sender: UIButton) {
        print("clicked")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addProfileData(_ sender: UIButton) {
        
        if isEditMode{
            let userid = exitingData?.userEmailid ?? ""
            print(userid)
//            editEmployee(id:emId)
            editUserPrfileDeatils(userid)
            navigationController?.popViewController(animated: true)
        }
        else{
            addUserPrfileDeatils()
            navigationPage()
        }
    }
}
extension ProfiledetailsVC{
    func navigationPage() {
        // Save login state
        UserDefaults.standard.set(true, forKey: "accessTokenKey")
        
        // Load UITabBarController from storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "UITabBarController") as? UITabBarController else {
            print("Failed to instantiate UITabBarController")
            return
        }

        // Set new rootViewController
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let navigationController = UINavigationController(rootViewController: tabBarController)
            sceneDelegate.window?.rootViewController = navigationController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
    
    func addUserPrfileDeatils() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}

        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<UserDetails> = UserDetails.fetchRequest()

        do {
            let existingDetails = try context.fetch(fetchRequest)

            // If exists, update the first one
            let login: UserDetails
            if let firstLogin = existingDetails.first {
                login = firstLogin
            } else {
                // If not exists, create a new one
                login = UserDetails(context: context)
            }

            login.userEmailid = self.userMailIdtxt.text
            login.userName = self.userNametxt.text
            login.userGendar = self.userGendartxt.text
            login.userPhoneNo = self.userPhonNotxt.text
            try context.save()
            print("profile data saved or updated.")

        } catch let error as NSError {
            print("Profile not fetch or save profile data: \(error), \(error.userInfo)")
        }
    }
    
    
    func editUserPrfileDeatils(_ emailId: String ) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let request = NSFetchRequest<UserDetails>(entityName: "UserDetails")
        let managedContext = appDelegate.persistentContainer.viewContext
        let predicate = NSPredicate(format: "userEmailid == %@", emailId)
         request.predicate = predicate
        do {
                  let searchResults = try managedContext.fetch(request)
                  if let  login = searchResults.first {
                
                      login.userEmailid = self.userMailIdtxt.text
                      login.userName = self.userNametxt.text
                      login.userGendar = self.userGendartxt.text
                      login.userPhoneNo = self.userPhonNotxt.text
                  }
             try managedContext.save()
            debugPrint("profile data updated..!!")
            
        } catch let error as NSError {
            debugPrint(error)
        }
    }
}

extension ProfiledetailsVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            profileImg.image = editedImage
            delegate?.didSelectProfileImage(editedImage)
            
            if let imageData = editedImage.jpegData(compressionQuality: 0.8) {
                      UserDefaults.standard.set(imageData, forKey: "profileImage")
                  }
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileImg.image = originalImage
            delegate?.didSelectProfileImage(originalImage)
            
            if let imageData = originalImage.jpegData(compressionQuality: 0.8) {
                       UserDefaults.standard.set(imageData, forKey: "profileImage")
                   }
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
