import UIKit

class ForecastCell: UICollectionViewCell {
    
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var imgForeCast: UIImageView!
    @IBOutlet var lblTemp: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.intiCellViews()
     
    }
    
    func intiCellViews() {
        self.lblTime.textColor = UIColor.black
        self.lblTemp.textColor = UIColor.black
        
        self.lblTime.font = UIFont.systemFont(ofSize: Device.IS_IPAD ? 23.0:16.0)
        self.lblTemp.font = UIFont.systemFont(ofSize: Device.IS_IPAD ? 23.0:16.0)
    }
    
}
