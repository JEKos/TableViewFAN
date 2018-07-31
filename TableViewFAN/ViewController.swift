import UIKit
import FBAudienceNetwork

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FBNativeAdDelegate, FBNativeAdsManagerDelegate  {
    
    @IBOutlet weak var tableview: UITableView!
    
    
    var Database: [String] = ["1","2","3","1","2","3","1","2","3","1","2","3","1","2","3","1","2","3","1","2","3","1","2","3","1","2","3","1","2","3","1","2","3","1","2","3"]
    
    let adRowStep = 5
    var adsManager: FBNativeAdsManager!
    var adsCellProvider: FBNativeAdTableViewCellProvider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        loadNativeAd()
        
        let nibAwardsAdsCell = UINib(nibName: "AdCell", bundle: nil)
        self.tableview.register(nibAwardsAdsCell, forCellReuseIdentifier: "adscellid")
        
        let nibell = UINib(nibName: "SimpleCell", bundle: nil)
        self.tableview.register(nibell, forCellReuseIdentifier: "simplecellid")
        
    }
    
    
    
    func loadNativeAd() {
        adsManager = FBNativeAdsManager(placementID: "VID_HD_16_9_46S_APP_INSTALL#573525062847749_849997161867203", forNumAdsRequested: 5)
        adsManager.delegate = self
        adsManager.mediaCachePolicy = .all
        adsManager.loadAds()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if adsCellProvider != nil {
            return Int(adsCellProvider.adjustCount(UInt(Database.count), forStride: UInt(adRowStep)))
        } else {
            return Database.count
        }
    }
    
    
    func nativeAdsLoaded() {
        adsCellProvider = FBNativeAdTableViewCellProvider(manager: adsManager, for: FBNativeAdViewType.genericHeight300)
        adsCellProvider.delegate = self
        
        if tableview != nil {
            tableview.reloadData()
        }
    }
    
    func nativeAdsFailedToLoadWithError(_ error: Error) {
        print("Error")
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if adsCellProvider != nil && adsCellProvider.isAdCell(at: indexPath, forStride: UInt(adRowStep)) {
            let nativeAd: FBNativeAd! = adsManager.nextNativeAd
            let cell = Bundle.main.loadNibNamed("AdCell", owner: self, options: nil)?[0] as! AdCell
            cell.backgroundColor = UIColor.clear
            nativeAd.unregisterView()
            // Wire up UIView with the native ad; only call to action button and media view will be clickable.
            //                nativeAd.registerView(forInteraction: cell.adplace, mediaView: cell.adCoverMediaView, iconView: cell.adIconImageView, viewController: self, clickableViews: [cell.adCallToActionButton, cell.adCoverMediaView])
            // Render native ads onto UIView
            cell.adTitleLabel.text = nativeAd.advertiserName
            cell.adBodyLabel.text = nativeAd.bodyText
            cell.adSocialContext.text = nativeAd.socialContext
            cell.sponsoredLabel.text = nativeAd.sponsoredTranslation
            cell.adCallToActionButton.setTitle(nativeAd.callToAction, for: .normal)
            cell.adChoicesView.nativeAd = nativeAd
            cell.adChoicesView.corner = UIRectCorner.topRight
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            cell.selectionStyle = .none
            let clickableViews = [cell.adIconImageView, cell.adTitleLabel, cell.adSocialContext, cell.adCallToActionButton] as [UIView]
            nativeAd.registerView(forInteraction: cell.adplace, mediaView: cell.adCoverMediaView, iconView: cell.adIconImageView, viewController: self, clickableViews: clickableViews)
            return cell
        }else{
            let cell = tableview.dequeueReusableCell(withIdentifier: "simplecellid") as! SimpleCell
            cell.backgroundColor = UIColor.clear
            
            cell.simpletext.text = Database[indexPath.row - Int(indexPath.row / adRowStep)]
        
            return cell
    }
    }
}

