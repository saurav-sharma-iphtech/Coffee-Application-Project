

import UIKit

class HomePageVC: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource{

    
    var arrPlaceList :[[String:String]] =  [[String:String]]()
    
    var arrbuttonName: [String] = []
    
//    var coffeeCategories: [String: [[String: Any]]] = [:]
    
    var All_Coffee: [[String : String]] =  [[String : String]]()
    var  Espresso_Based: [[String : String]] =  [[String : String]]()
    var Brewed_Coffee: [[String : String]] =  [[String : String]]()
    var Specialty_Coffee: [[String : String]] =  [[String : String]]()
    var International_Coffee: [[String : String]] =  [[String : String]]()
    
    enum DisplayMode{
       case All_Coffee
       case Espresso_Based
       case Brewed_Coffee
       case Specialty_Coffee
       case International_Coffee
    }
    
    var currentCase : DisplayMode = .All_Coffee

    @IBOutlet weak var offerCoffeeListSlider: UICollectionView!
    
    @IBOutlet weak var firstCoffeeListSlider: UICollectionView!
    @IBOutlet weak var sliderBtn: UICollectionView!
    
    @IBOutlet weak var sliderView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tourPlaceLsit()
        setupview()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAutoSlide()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAutoSlide()
    }

    
    @IBAction func logout(_ sender: UIButton) {
        UserDefaults.standard.setValue("false", forKey:"accessTokenKey" )
        print("logout")
        navigationController?.popToRootViewController(animated: true)
     

    }
    
//    func configure(with coffee: [String: Any]) {
////           idLabel.text = coffee["id"] as? String
//          coffe.text = coffee["name"] as? String
//           if let price = coffee["price"] as? Double {
//               priceLabel.text = "$\(price)"
//           } else {
//               priceLabel.text = "-"
//           }
//           if let imageName = coffee["image"] as? String {
//               coffeeImageView.image = UIImage(named: imageName)
//           }
//       }
    
}


extension HomePageVC{
    func tourPlaceLsit(){
        
     
            
            All_Coffee = [
                ["Description": "coffee_001", "name": "Espresso", "price": "120.0", "image": "a"],
                ["Description": "coffee_002", "name": "Doppio", "price": "120.0", "image": "b"],
                ["Description": "coffee_011", "name": "Cold Brew", "price": "180.0", "image": "c"],
                ["Description": "coffee_012", "name": "Iced Coffee", "price": "150.0", "image": "d"],
                ["Description": "coffee_020", "name": "Italian Affogato", "price": "210.0", "image": "e"],
                ["Description": "coffee_021", "name": "Spanish Cortado", "price": "160.0", "image": "f"],
                ["Description": "coffee_024", "name": "Japanese Kyoto Coffee", "price": "200.0", "image": "g"],
                ["Description": "coffee_025", "name": "Indian Filter Coffee", "price": "100.0", "image": "h"],
                ["Description": "coffee_009", "name": "Cortado", "price": "150.0", "image": "c"],
                ["Description": "coffee_012", "name": "Iced Coffee", "price": "150.0", "image": "a"],
                ["Description": "coffee_020", "name": "Italian Affogato", "price": "210.0", "image": "b"],
                ["Description": "coffee_025", "name": "Indian Filter Coffee", "price": "100.0", "image": "c"],
                ["Description": "coffee_026", "name": "Mexican Cafe de Olla", "price": "150.0", "image": "d"],
                
            ]
       
            Espresso_Based = [
                ["Description": "coffee_001", "name": "Espresso", "price": "100.0", "image": "a"],
                ["Description": "coffee_002", "name": "Doppio", "price": "120.0", "image": "b"],
                ["Description": "coffee_003", "name": "Ristretto", "price": "110.0", "image": "c"],
                ["Description": "coffee_004", "name": "Macchiato", "price": "140.0", "image": "d"],
                ["Description": "coffee_005", "name": "Cappuccino", "price": "150.0", "image": "e"],
                ["Description": "coffee_006", "name": "Latte", "price": "170.0", "image": "f"],
                ["Description": "coffee_007", "name": "Mocha", "price": "180.0", "image": "g"],
                ["Description": "coffee_008", "name": "Flat White", "price": "160.0", "image": "h"],
                ["Description": "coffee_009", "name": "Cortado", "price": "150.0", "image": "c"]
            ]
            Brewed_Coffee = [
                ["Description": "coffee_010", "name": "Americano", "price": "120.0", "image": "f"],
                ["Description": "coffee_011", "name": "Cold Brew", "price": "180.0", "image": "g"],
                ["Description": "coffee_012", "name": "Iced Coffee", "price": "150.0", "image": "u"],
                ["Description": "coffee_013", "name": "Turkish Coffee", "price": "130.0", "image": "c"],
                ["Description": "coffee_014", "name": "French Press", "price": "140.0", "image": "d"],
                ["Description": "coffee_015", "name": "Pour Over", "price": "160.0", "image": "e"]
            ]
            Specialty_Coffee = [
                ["Description": "coffee_016", "name": "Affogato", "price":" 200.0", "image": "g"],
                ["Description": "coffee_017", "name": "Irish Coffee", "price": "220.0", "image": "h"],
                ["Description": "coffee_018", "name": "Vietnamese Coffee", "price": "180.0", "image": "d"],
                ["Description": "coffee_019", "name": "Greek Coffee", "price": "150.0", "image": "c"],
                ["Description": "coffee_020", "name": "Italian Affogato", "price": "210.0", "image": "d"],
                ["Description": "coffee_021", "name": "Spanish Cortado", "price": "160.0", "image": "a"]
            ]
            International_Coffee = [
                ["Description": "coffee_022", "name": "Cuban Coffee", "price": "130.0", "image": "b"],
                ["Description": "coffee_023", "name": "Brazilian Cafezinho", "price": "120.0", "image": "g"],
                ["Description": "coffee_024", "name": "Japanese Kyoto Coffee", "price": "200.0", "image": "a"],
                ["iDescriptiond": "coffee_025", "name": "Indian Filter Coffee", "price": "100.0", "image": "f"],
                ["Description": "coffee_026", "name": "Mexican Cafe de Olla", "price": "150.0", "image": "e"],
                ["Description": "coffee_027", "name": "Saudi Qahwa", "price": "180.0", "image": "a"]
            ]
       
        
        arrbuttonName = ["a","b","c","d","e","f","g","h","last"]
        
        arrPlaceList = [
            [
                "name" :"All-Coffee",
                "imageName" :   "a"
            ],
            [
                "name" :"Espresso-Based",
                "imageName" :   "a"
            ],
            [
                "name" :"Brewed Coffee",
                "imageName" :  "b"
            ],
            [
                "name" :"Specialty Coffee",
                "imageName" :   "c"
            ],
//            [
//                "name" :"Iced Espresso",
//                "imageName" :   "d"
//            ],
//            [
//                "name" :"Blended Drinks",
//                "imageName" :   "e"
//            ],
            [
                "name" :"International",
                "imageName" :   "f"
            ]
//            [
//                "name" :"Fusion Coffee",
//                "imageName" :   "g"
//            ]
           
        ]
    }
}



extension HomePageVC {
    
    func setupview(){
        self.sliderView.delegate = self
        self.sliderView.dataSource = self
        self.sliderView.register(UINib(nibName: "HomeFirstCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeFirstCollectionViewCell")
        
        self.sliderBtn.delegate = self
        self.sliderBtn.dataSource = self
        self.sliderBtn.register(UINib(nibName: "ButtonViewCell", bundle: nil), forCellWithReuseIdentifier: "ButtonViewCell")
        
        self.firstCoffeeListSlider.delegate = self
        self.firstCoffeeListSlider.dataSource = self
        self.firstCoffeeListSlider.register(UINib(nibName: "CoffeeLCVC", bundle: nil), forCellWithReuseIdentifier: "CoffeeLCVC")
        
        self.offerCoffeeListSlider.delegate = self
        self.offerCoffeeListSlider.dataSource = self
        self.offerCoffeeListSlider.register(UINib(nibName: "OffersCVC", bundle: nil), forCellWithReuseIdentifier: "OffersCVC")
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 101{
            return arrbuttonName.count
        }
        else if collectionView.tag == 102{
            return arrPlaceList.count
        }
        else if collectionView.tag == 103{
            switch currentCase{
            case .All_Coffee:
                return All_Coffee.count
            case .Espresso_Based:
                 return Espresso_Based.count
            case .Brewed_Coffee:
                return Brewed_Coffee.count
            case .Specialty_Coffee:
                return Specialty_Coffee.count
            case .International_Coffee:
                return International_Coffee.count
            }
            
        }
        else{
            return arrPlaceList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 101{
            guard let cell = self.sliderView.dequeueReusableCell(withReuseIdentifier: "HomeFirstCollectionViewCell", for: indexPath) as? HomeFirstCollectionViewCell else{
                return UICollectionViewCell()
            }
            
            let imgNamePlace = arrbuttonName[indexPath.row]
            cell.sliderImg.image = imgNamePlace.isEmpty ? UIImage(named:"profile_avatar") :  UIImage(named: imgNamePlace)
            
            return  cell
        }else if collectionView.tag == 102{
            
            guard let cell2 = self.sliderBtn.dequeueReusableCell(withReuseIdentifier: "ButtonViewCell", for: indexPath) as? ButtonViewCell else{
                return UICollectionViewCell()
            }
            
            let ss = arrPlaceList[indexPath.row]
            cell2.btnlbl.text = ss["name"]
            
            
            return  cell2
        }
        else if collectionView.tag == 103{
            switch currentCase{
                
            case .All_Coffee:
                guard let cell3 = self.firstCoffeeListSlider.dequeueReusableCell(withReuseIdentifier: "CoffeeLCVC", for: indexPath) as? CoffeeLCVC else{
                    return UICollectionViewCell()
                }
                
                
//                let allcoffee = coffeeCategories["All Coffee"] ?? []
                let coffee = All_Coffee[indexPath.row]
                cell3.coffeen.text = coffee["name"]
                cell3.price.text = "$" + "\(coffee["price"] ?? "" )"
//                cell3.img.image = coffee["image"] as? UIImage
                let imgNamePlace = coffee["image"] ?? ""
                cell3.img.image = imgNamePlace.isEmpty ? UIImage(named:"b") :  UIImage(named: imgNamePlace)

               
               
                   return cell3
            case .Espresso_Based:
              
                guard let cell3 = self.firstCoffeeListSlider.dequeueReusableCell(withReuseIdentifier: "CoffeeLCVC", for: indexPath) as? CoffeeLCVC else{
                    return UICollectionViewCell()
                }
                
                
//                let allcoffee = coffeeCategories["Espresso-Based"] ?? []
                let coffee = Espresso_Based[indexPath.row]
                cell3.coffeen.text = coffee["name"]
//                cell3.img.image = coffee["image"] as? UIImage
                let imgNamePlace = Espresso_Based[indexPath.row]["image"] ?? ""
                cell3.img.image = imgNamePlace.isEmpty ? UIImage(named:"profile_avatar") :  UIImage(named: imgNamePlace)
                   return cell3
                
            case .Brewed_Coffee:
                guard let cell3 = self.firstCoffeeListSlider.dequeueReusableCell(withReuseIdentifier: "CoffeeLCVC", for: indexPath) as? CoffeeLCVC else{
                    return UICollectionViewCell()
                }
                
                
//                let allcoffee = coffeeCategories["Brewed-Coffee"] ?? []
                let coffee = Brewed_Coffee[indexPath.row]
                cell3.coffeen.text = coffee["name"]
//                cell3.img.image = coffee["image"] as? UIImage
                let imgNamePlace = Brewed_Coffee[indexPath.row]["image"] ?? ""
                cell3.img.image = imgNamePlace.isEmpty ? UIImage(named:"profile_avatar") :  UIImage(named: imgNamePlace)
                   return cell3
                
            case .Specialty_Coffee:
                guard let cell3 = self.firstCoffeeListSlider.dequeueReusableCell(withReuseIdentifier: "CoffeeLCVC", for: indexPath) as? CoffeeLCVC else{
                    return UICollectionViewCell()
                }
                
                
//                let allcoffee = coffeeCategories["Specialty-Coffee"] ?? []
                let coffee = Specialty_Coffee[indexPath.row]
                cell3.coffeen.text = coffee["name"]
//                cell3.img.image = coffee["image"] as? UIImage
                let imgNamePlace = Specialty_Coffee[indexPath.row]["image"] ?? ""
                cell3.img.image = imgNamePlace.isEmpty ? UIImage(named:"profile_avatar") :  UIImage(named: imgNamePlace)
                   return cell3
                
            case .International_Coffee:
                guard let cell3 = self.firstCoffeeListSlider.dequeueReusableCell(withReuseIdentifier: "CoffeeLCVC", for: indexPath) as? CoffeeLCVC else{
                    return UICollectionViewCell()
                }
                
                
//                let allcoffee = coffeeCategories["International coffee"] ?? []
                let coffee = International_Coffee[indexPath.row]
                cell3.coffeen.text = coffee["name"]
//                cell3.img.image = coffee["image"] as? UIImage
                let imgNamePlace = International_Coffee[indexPath.row]["image"] ?? ""
                cell3.img.image = imgNamePlace.isEmpty ? UIImage(named:"profile_avatar") :  UIImage(named: imgNamePlace)
                
                   return cell3
            }
        }
        else {
            
            guard let cell4 = self.offerCoffeeListSlider.dequeueReusableCell(withReuseIdentifier: "OffersCVC", for: indexPath) as? OffersCVC else{
                return UICollectionViewCell()
            }
            
            let imgNamePlace = arrPlaceList[indexPath.row]["imageName"] ?? ""
            cell4.coffeename.text = arrPlaceList[indexPath.row]["name"]
            cell4.img.image = imgNamePlace.isEmpty ? UIImage(named:"profile_avatar") :  UIImage(named: imgNamePlace)
            return  cell4
        }
        
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let contentSizeWidth =  collectionView.bounds.size.width
        let cellWidth =  contentSizeWidth * 0.5 - 10
        return  CGSize(width:cellWidth , height:cellWidth)
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 102 {
            print("cliked you....!!!!!")
            let selectedItem = arrPlaceList[indexPath.row]["name"]
            if selectedItem == "All-Coffee"{
                currentCase = .All_Coffee
                firstCoffeeListSlider.reloadData()
            }
            else if  selectedItem == "Espresso-Based" {
                currentCase = .Espresso_Based
                firstCoffeeListSlider.reloadData()
            }
            else if  selectedItem == "Brewed Coffee" {
                currentCase = .Brewed_Coffee
                firstCoffeeListSlider.reloadData()
            }
            else if  selectedItem == "Specialty Coffee" {
                currentCase = .Specialty_Coffee
                firstCoffeeListSlider.reloadData()
            }
            else{
                currentCase = .International_Coffee
                firstCoffeeListSlider.reloadData()
            }
            
        }
        if collectionView.tag == 103{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let sheetVC = storyboard.instantiateViewController(withIdentifier: "CoffeeDetailVC") as? CoffeeDetailVC {
                
                // pass data
//                let allcoffee = coffeeCategories["International coffee"] ?? []
                switch currentCase{
                case .All_Coffee:
                    let selectedItem = All_Coffee[indexPath.row]
                    sheetVC.coffeeData = selectedItem
                case .Espresso_Based:
                    let selectedItem = Espresso_Based[indexPath.row]
                    sheetVC.coffeeData = selectedItem
                case .Brewed_Coffee:
                    let selectedItem = Brewed_Coffee[indexPath.row]
                    sheetVC.coffeeData = selectedItem
                case .Specialty_Coffee:
                    let selectedItem = Specialty_Coffee[indexPath.row]
                    sheetVC.coffeeData = selectedItem
                case .International_Coffee:
                    let selectedItem = International_Coffee[indexPath.row]
                    sheetVC.coffeeData = selectedItem
                }
                
                
                if let sheet = sheetVC.sheetPresentationController {
                    sheet.detents = [
//                        .medium(),  // Half screen
                        .large()    // Full screen
                    ]
                    sheet.prefersGrabberVisible = true
                    sheet.preferredCornerRadius = 20
                }
                
                self.present(sheetVC, animated: true, completion: nil)
            }
        }
        
    }
    
}

extension HomePageVC{
    
}

extension HomePageVC {

    // Timer to handle auto-scrolling
    var autoSlideTimer: Timer? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.timer) as? Timer }
        set { objc_setAssociatedObject(self, &AssociatedKeys.timer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    var currentSlideIndex: Int {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.index) as? Int ?? 0 }
        set { objc_setAssociatedObject(self, &AssociatedKeys.index, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    private struct AssociatedKeys {
        static var timer = "autoSlideTimer"
        static var index = "currentSlideIndex"
    }

    func startAutoSlide() {
        stopAutoSlide() // Just in case
        autoSlideTimer = Timer.scheduledTimer(timeInterval: 3.0,target: self,selector: #selector(autoScrollCollectionView),
                                              userInfo: nil,
                                              repeats: true)
    }

    func stopAutoSlide() {
        autoSlideTimer?.invalidate()
        autoSlideTimer = nil
    }

    @objc private func autoScrollCollectionView() {
        guard !arrbuttonName.isEmpty else { return }

        currentSlideIndex += 1

        if currentSlideIndex >= arrbuttonName.count {
            currentSlideIndex = 0
            sliderView.scrollToItem(at: IndexPath(item: currentSlideIndex, section: 0),
                                    at: .left,
                                    animated: false)
        } else {
            sliderView.scrollToItem(at: IndexPath(item: currentSlideIndex, section: 0),
                                    at: .left,
                                    animated: true)
        }
    }
}
