import UIKit
import Alamofire
import AlamofireImage
import CoreLocation

class ForecastVC: UIViewController {

    @IBOutlet var cvForecast: UICollectionView!
    var arrForecast = [ForecastList]()
    var cityCoordinate: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        // Do any additional setup after loading the view.
    }
    
    func fetchFiveDays(){
        let req = FiveDaysForecastReq()
        req.latitude = NSNumber(value: cityCoordinate.latitude)
        req.longitude = NSNumber(value: cityCoordinate.longitude)
        req.units = UserDefaults.standard.getDefaultUnit()
        
        WebService.sharedInstance.doCallGetAPI(APIUrl.FiveDaysForcast, params: req.parameters()) { (apiResponse: FiveDaysForecastRes?, result) in
            
            if let error = result.error {
                Utility.showErrorAlertMessage(titleMessage: "Error", alertMsg: error.localizedDescription)
                return
            }
            
            if let response = apiResponse, response.statusCode == 200 {
                if let list = response.list, list.count > 0 {
                    self.arrForecast = list
                }
                
                DispatchQueue.main.async {
                    self.cvForecast.reloadData()
                }
            }else {
                Utility.showErrorAlertMessage(titleMessage: APIError.title, alertMsg: APIError.noResponseFound)
                return
            }
            
        }
    }

}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension ForecastVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as! ForecastCell
        let forcastList = self.arrForecast[indexPath.item]
        
        if let dt = forcastList.dt {
            cell.lblTime.text = StringUtility.getTime(timeInterval: dt.intValue, isMinute: false)
        }
        
        if let main = forcastList.main {
            cell.lblTemp.text = StringUtility.getTemperature(temperature: main.temp)
        }
        
        if let weather = forcastList.weatherInfo, let firstWeather = weather.first{
            
            let url = URL(string: StringUtility.getImageUrl(logo: firstWeather.icon!))!
            cell.imgForeCast.af_setImage(withURL: url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if Device.IS_IPAD {
            return CGSize(width: 100, height: 200)
        }
        
        return CGSize(width: 84, height: 150)
    }
    
}
