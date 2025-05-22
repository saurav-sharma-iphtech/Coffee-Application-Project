//
//  CountryVC.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 06/05/25.
//

import UIKit


//Define the protocal
protocol CountrySelectionDelegate: AnyObject {
    func didSelectCountry(_ country: String)
}

struct CountryResponse: Codable {
    let data: [Book]
}

struct Book: Codable {
    let name: String
    let dial_code: String
    let code: String
}


class CountryVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    weak var delegate: CountrySelectionDelegate?
    
//    let countries = [
//        "🇦🇫 AFG +93", "🇦🇱 ALB +355", "🇩🇿 DZA +213", "🇦🇩 AND +376", "🇦🇴 AGO +244", "🇦🇬 ATG +1-268", "🇦🇷 ARG +54", "🇦🇲 ARM +374",
//           "🇦🇺 AUS +61", "🇦🇹 AUT +43", "🇦🇿 AZE +994", "🇧🇸 BHS +1-242", "🇧🇭 BHR +973", "🇧🇩 BGD +880", "🇧🇧 BRB +1-246", "🇧🇾 BLR +375",
//           "🇧🇪 BEL +32", "🇧🇿 BLZ +501", "🇧🇯 BEN +229", "🇧🇹 BTN +975", "🇧🇴 BOL +591", "🇧🇦 BIH +387", "🇧🇼 BWA +267", "🇧🇷 BRA +55",
//           "🇧🇳 BRN +673", "🇧🇬 BGR +359", "🇧🇫 BFA +226", "🇧🇮 BDI +257", "🇨🇻 CPV +238", "🇰🇭 KHM +855", "🇨🇲 CMR +237", "🇨🇦 CAN +1",
//           "🇨🇫 CAF +236", "🇹🇩 TCD +235", "🇨🇱 CHL +56", "🇨🇳 CHN +86", "🇨🇴 COL +57", "🇰🇲 COM +269", "🇨🇬 COG +242", "🇨🇷 CRI +506",
//           "🇭🇷 HRV +385", "🇨🇺 CUB +53", "🇨🇾 CYP +357", "🇨🇿 CZE +420", "🇨🇩 COD +243", "🇩🇰 DNK +45", "🇩🇯 DJI +253", "🇩🇲 DMA +1-767",
//           "🇩🇴 DOM +1-809", "🇪🇨 ECU +593", "🇪🇬 EGY +20", "🇸🇻 SLV +503", "🇬🇶 GNQ +240", "🇪🇷 ERI +291", "🇪🇪 EST +372", "🇸🇿 SWZ +268",
//           "🇪🇹 ETH +251", "🇫🇯 FJI +679", "🇫🇮 FIN +358", "🇫🇷 FRA +33", "🇬🇦 GAB +241", "🇬🇲 GMB +220", "🇬🇪 GEO +995", "🇩🇪 DEU +49",
//           "🇬🇭 GHA +233", "🇬🇷 GRC +30", "🇬🇩 GRD +1-473", "🇬🇹 GTM +502", "🇬🇳 GIN +224", "🇬🇼 GNB +245", "🇬🇾 GUY +592", "🇭🇹 HTI +509",
//           "🇭🇳 HND +504", "🇭🇺 HUN +36", "🇮🇸 ISL +354", "🇮🇳 IND +91", "🇮🇩 IDN +62", "🇮🇷 IRN +98", "🇮🇶 IRQ +964", "🇮🇪 IRL +353",
//           "🇮🇱 ISR +972", "🇮🇹 ITA +39", "🇯🇲 JAM +1-876", "🇯🇵 JPN +81", "🇯🇴 JOR +962", "🇰🇿 KAZ +7", "🇰🇪 KEN +254", "🇰🇮 KIR +686",
//           "🇰🇼 KWT +965", "🇰🇬 KGZ +996", "🇱🇦 LAO +856", "🇱🇻 LVA +371", "🇱🇧 LBN +961", "🇱🇸 LSO +266", "🇱🇷 LBR +231", "🇱🇾 LBY +218",
//           "🇱🇮 LIE +423", "🇱🇹 LTU +370", "🇱🇺 LUX +352", "🇲🇬 MDG +261", "🇲🇼 MWI +265", "🇲🇾 MYS +60", "🇲🇻 MDV +960", "🇲🇱 MLI +223",
//           "🇲🇹 MLT +356", "🇲🇭 MHL +692", "🇲🇷 MRT +222", "🇲🇺 MUS +230", "🇲🇽 MEX +52", "🇫🇲 FSM +691", "🇲🇩 MDA +373", "🇲🇨 MCO +377",
//           "🇲🇳 MNG +976", "🇲🇪 MNE +382", "🇲🇦 MAR +212", "🇲🇿 MOZ +258", "🇲🇲 MMR +95", "🇳🇦 NAM +264", "🇳🇷 NRU +674", "🇳🇵 NPL +977",
//           "🇳🇱 NLD +31", "🇳🇿 NZL +64", "🇳🇮 NIC +505", "🇳🇪 NER +227", "🇳🇬 NGA +234", "🇰🇵 PRK +850", "🇲🇰 MKD +389", "🇳🇴 NOR +47",
//           "🇴🇲 OMN +968", "🇵🇰 PAK +92", "🇵🇼 PLW +680", "🇵🇸 PSE +970", "🇵🇦 PAN +507", "🇵🇬 PNG +675", "🇵🇾 PRY +595", "🇵🇪 PER +51",
//           "🇵🇭 PHL +63", "🇵🇱 POL +48", "🇵🇹 PRT +351", "🇶🇦 QAT +974", "🇷🇴 ROU +40", "🇷🇺 RUS +7", "🇷🇼 RWA +250", "🇰🇳 KNA +1-869",
//           "🇱🇨 LCA +1-758", "🇻🇨 VCT +1-784", "🇼🇸 WSM +685", "🇸🇲 SMR +378", "🇸🇹 STP +239", "🇸🇦 SAU +966", "🇸🇳 SEN +221",
//           "🇷🇸 SRB +381", "🇸🇨 SYC +248", "🇸🇱 SLE +232", "🇸🇬 SGP +65", "🇸🇰 SVK +421", "🇸🇮 SVN +386", "🇸🇧 SLB +677", "🇸🇴 SOM +252",
//           "🇿🇦 ZAF +27", "🇰🇷 KOR +82", "🇸🇸 SSD +211", "🇪🇸 ESP +34", "🇱🇰 LKA +94", "🇸🇩 SDN +249", "🇸🇷 SUR +597", "🇸🇪 SWE +46",
//           "🇨🇭 CHE +41", "🇸🇾 SYR +963", "🇹🇼 TWN +886", "🇹🇯 TJK +992", "🇹🇿 TZA +255", "🇹🇭 THA +66", "🇹🇬 TGO +228", "🇹🇰 TKL +690",
//           "🇹🇴 TON +676", "🇹🇹 TTO +1-868", "🇹🇳 TUN +216", "🇹🇷 TUR +90", "🇹🇲 TKM +993", "🇹🇻 TUV +688", "🇺🇬 UGA +256", "🇺🇦 UKR +380",
//           "🇦🇪 ARE +971", "🇬🇧 GBR +44", "🇺🇸 USA +1", "🇺🇾 URY +598", "🇺🇿 UZB +998", "🇻🇺 VUT +678", "🇻🇦 VAT +379", "🇻🇪 VEN +58",
//           "🇻🇳 VNM +84", "🇾🇪 YEM +967", "🇿🇲 ZMB +260", "🇿🇼 ZWE +263"
//    ]
    

    
    @IBOutlet weak var TableViewC: UITableView!
    
    var arrList: [Book] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        fetchApi()
        setupTable()
    }

}



extension CountryVC{
    
    func setupTable(){
        self.TableViewC.delegate = self
        self.TableViewC.dataSource = self
        
        self.TableViewC.register( UINib(nibName: "CountryViewCell", bundle: nil), forCellReuseIdentifier: "CountryViewCell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrList.count
       }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"CountryViewCell", for: indexPath) as? CountryViewCell else { return UITableViewCell() }
        
        
        let list = arrList[indexPath.row]
        cell.lblCountry.text = list.dial_code
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let list = arrList[indexPath.row]
        let selectedCountry = list.dial_code
        delegate?.didSelectCountry(selectedCountry)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 60
      }
  
}


extension CountryVC{
    
    
    func fetchApi(){
        
            let url = URL(string: "https://countriesnow.space/api/v0.1/countries/codes")!
        
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            
            if let error = error{
                print("error",error)
                return
            }
            guard let httpRes = response as? HTTPURLResponse, (200...299).contains(httpRes.statusCode) else{
                print("error")
                return
            }
            
            if let data = data {
                do {
//
                    
                 

                    let bookListResponse = try JSONDecoder().decode(CountryResponse.self, from: data)
                    self.arrList = bookListResponse.data
                    
                    print(bookListResponse)
                    //main
                    DispatchQueue.main.async {
                        self.TableViewC.reloadData()
                    }

                } catch {
                    print("Decoding error:", error)
                }
            }
        }
        task.resume()
    }
    
  
}

