import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblCityName: UILabel!
    
    @IBOutlet var lblTemp: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initCellViews()
        // Initialization code
    }

    func initCellViews()  {
        self.lblTime.font = UIFont.systemFont(ofSize: 15.0)
        self.lblCityName.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        self.lblTemp.font = UIFont.boldSystemFont(ofSize: 30.0)

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
