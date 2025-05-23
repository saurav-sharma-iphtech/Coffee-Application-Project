

import UIKit
import CoreData

class ProfileVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,
                 UICollectionViewDelegateFlowLayout, ProfileImageDelegate,
                 UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func didSelectProfileImage(_ image: UIImage) {
        imgProfile.image = image
    }
    
    @IBOutlet weak var bgImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!

    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button: UIButton!
    let arrbuttonName = ["a","b","c","d","e","f","g","h","last"]
    enum DisplayMode{
       case Posts
       case Ordered
    }
    var userdata :[UserDetails] = []
    var currentMode : DisplayMode = .Posts
    
    @IBOutlet weak var postsOrderView: UICollectionView!
    @IBOutlet weak var imgProfile: UIImageView!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        setUpView()
        setImage()
//        fetchData()
//        userName.text = userdata.first?.userName
     
    }
//
    
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        userName.text = userdata.first?.userName
        
        if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
           let savedImage = UIImage(data: imageData) {
            imgProfile.image = savedImage
        }
        if let imageData = UserDefaults.standard.data(forKey: "bgImage"),
           let savedImage = UIImage(data: imageData) {
            bgImage.image = savedImage
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
               bgImage.addGestureRecognizer(tapGesture)
               bgImage.isUserInteractionEnabled = true
    }
    @objc func imageTapped() {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        }
    
    @IBAction func editProfileBtn(_ sender: UIButton) {
        let data = userdata.first
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storybord.instantiateViewController(withIdentifier: "ProfiledetailsVC") as? ProfiledetailsVC{
            vc.exitingData = data
            vc.delegate = self
            vc.isEditMode = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func logoutJustEample(_ sender: UIButton) {
        // 1. Clear login state
        UserDefaults.standard.set(false, forKey: "accessTokenKey")

        // 2. Instantiate the login screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "Loading_Page_VC") as! Loading_Page_VC
        let rootNav = UINavigationController(rootViewController: loginVC)

        // 3. Replace the root view controller with animation
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {

            UIView.transition(with: window,
                              duration: 0.4,
                              options: [.transitionFlipFromLeft],
                              animations: {
                                  window.rootViewController = rootNav
                              },
                              completion: nil)
        }
    }
    
    @IBAction func btnPosts(_ sender:UIButton) {
        currentMode = .Posts
        postsOrderView.reloadData()
        button2.backgroundColor = UIColor.white
        button.backgroundColor = .clear
       
    }
    

    @IBAction func btnOrders(_ sender: UIButton) {
        currentMode = .Ordered
        postsOrderView.reloadData()
        button.backgroundColor = UIColor.white
        button2.backgroundColor = .clear
        
    }

    private func setImage(){
        imgProfile.layer.borderWidth=5.0
        imgProfile.layer.masksToBounds = false
        imgProfile.layer.borderColor = UIColor.white.cgColor
        imgProfile.layer.cornerRadius = imgProfile.frame.size.height/2
        imgProfile.clipsToBounds = true
        button2.layer.cornerRadius = 10
        button.layer.cornerRadius = 10
    }
    
    
}

extension ProfileVC{
    func   setUpView(){
        
        self.postsOrderView.delegate = self
        self.postsOrderView.dataSource = self
        self.postsOrderView.register(UINib(nibName: "PostsCVC", bundle: nil), forCellWithReuseIdentifier: "PostsCVC")
        self.postsOrderView.register(UINib(nibName: "OrderedCVC", bundle: nil), forCellWithReuseIdentifier: "OrderedCVC")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrbuttonName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch currentMode{
            
        case .Posts :
            guard let cell = self.postsOrderView.dequeueReusableCell(withReuseIdentifier: "PostsCVC", for: indexPath) as? PostsCVC else{
                return UICollectionViewCell()
            }
            
            
            let imgName = arrbuttonName[indexPath.row]
            
            cell.imgposts.image = imgName.isEmpty ? UIImage(named: "a") : UIImage (named: imgName)
            
            return cell
            
        case .Ordered:
            
            guard let cell = self.postsOrderView.dequeueReusableCell(withReuseIdentifier: "OrderedCVC", for: indexPath) as? OrderedCVC else{
                return UICollectionViewCell()
            }
            let imgname = arrbuttonName[indexPath.row]
            cell.imgg.image = imgname.isEmpty ? UIImage(named: "a") : UIImage(named: imgname)
            
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForIteamAt indexPath:IndexPath )-> CGSize {
            
            let contentwidth = collectionView.bounds.size.width
            let cellwidth = contentwidth * 0.5 - 10
            return CGSize(width: cellwidth , height: cellwidth)
        }
    }
}

extension ProfileVC{
    func fetchData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<UserDetails>(entityName: "UserDetails")
        
        fetchRequest.returnsObjectsAsFaults = false
        do{
            let user = try managedContext.fetch(fetchRequest)
            
            self.userdata = user
            
            debugPrint(user)
        }catch let error as NSError {
            debugPrint(error)
        }
        
    }
}

extension ProfileVC{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let editedImage = info[.editedImage] as? UIImage {
            bgImage.image = editedImage
            saveImageToUserDefaults(image: editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            bgImage.image = originalImage
            saveImageToUserDefaults(image: originalImage)
        }
    }

    func saveImageToUserDefaults(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            UserDefaults.standard.set(imageData, forKey: "bgImage")
        }
    }

}

