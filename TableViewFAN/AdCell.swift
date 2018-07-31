import UIKit
import FBAudienceNetwork

class AdCell: UITableViewCell {

    @IBOutlet weak var adplace: UIView!
    @IBOutlet weak var adIconImageView: FBAdIconView!
    @IBOutlet weak var adCoverMediaView: FBMediaView!
    @IBOutlet weak var adTitleLabel: UILabel!
    @IBOutlet weak var adSocialContext: UILabel!
    @IBOutlet weak var adBodyLabel: UILabel!
    @IBOutlet weak var adCallToActionButton: UIButton!
    @IBOutlet weak var sponsoredLabel: UILabel!
    @IBOutlet weak var adChoicesView: FBAdChoicesView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.adCoverMediaView.frame = CGRect(x: 7, y: 83, width: 287, height: 161)
        self.adplace.layer.cornerRadius = 5
        self.adplace.layer.masksToBounds = true
        self.backgroundColor = UIColor.lightGray
        self.adIconImageView.layer.cornerRadius = 10.0
        self.adIconImageView.layer.masksToBounds = true
        self.adCallToActionButton.setTitleColor(UIColor.white, for: .normal)
        self.adTitleLabel.textColor = UIColor.black
        self.adTitleLabel.adjustsFontSizeToFitWidth = true
        self.adBodyLabel.textColor = UIColor.black.withAlphaComponent(0.8)
        self.adBodyLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.sponsoredLabel.textColor = UIColor.black.withAlphaComponent(0.5)
    }
    
}
