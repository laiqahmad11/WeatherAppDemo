import UIKit

class WeatherDetailCell: UITableViewCell {

    @IBOutlet var lblLeftTitle: UILabel!
    @IBOutlet var lblLeftValue: UILabel!
    
    @IBOutlet var lblRightTitle: UILabel!
    @IBOutlet var lblRightValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.intiCellViews()
    }
    func intiCellViews() {
        self.lblLeftTitle.textColor = UIColor.black
        self.lblLeftValue.textColor = UIColor.black
        self.lblRightTitle.textColor = UIColor.black
        self.lblRightValue.textColor = UIColor.black
        
        self.lblLeftTitle.font = UIFont.systemFont(ofSize: Device.IS_IPAD ? 22.0:18.0)
        self.lblLeftValue.font = UIFont.systemFont(ofSize: Device.IS_IPAD ? 22.0:18.0)
        
        self.lblRightTitle.font = UIFont.systemFont(ofSize: Device.IS_IPAD ? 22.0:18.0)
        self.lblRightValue.font = UIFont.systemFont(ofSize: Device.IS_IPAD ? 22.0:18.0)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
