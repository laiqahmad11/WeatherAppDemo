import UIKit
import CoreLocation

class WeatherDetailCellData {
    var leftText: String?
    var rightText: String?
    var leftValue: String?
    var rightValue: String?
    init() {
        
    }
}

class WeatherDetailVC: UIViewController {
    
    
    @IBOutlet var vwHeader: UIView!
    @IBOutlet var lblCityName: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblTodayTemp: UILabel!
    @IBOutlet var tblDetail: UITableView!
    @IBOutlet var btnBack: UIButton!
    var todaysForeCast = TodayForcastRes()
    
    var cityCoordinate: CLLocationCoordinate2D!
    var arrWeatherDetailCell =  [WeatherDetailCellData]()
    var forecastVC: ForecastVC? {
        let vc = children.compactMap({ $0 as? ForecastVC }).first
        vc?.cityCoordinate = self.cityCoordinate
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.fetchTodayForecast()
        forecastVC?.fetchFiveDays()
        // Do any additional setup after loading the view.
    }
    
    func initView(){
        self.navigationController?.isNavigationBarHidden = false
        self.tblDetail.tableFooterView = UIView()
        self.vwHeader.backgroundColor = UIColor.clear
        
        self.lblCityName.textColor = UIColor.black
        self.lblDescription.textColor = UIColor.black
        self.lblTodayTemp.textColor = UIColor.black
        
        self.lblCityName.font = UIFont.boldSystemFont(ofSize: Device.IS_IPAD ? 28.0:25.0)
        self.lblDescription.font = UIFont.systemFont(ofSize: Device.IS_IPAD ? 25:20.0)
        self.lblTodayTemp.font = UIFont.boldSystemFont(ofSize: Device.IS_IPAD ? 45:40)
    }
    
    func fetchTodayForecast(){
        let req = TodayForcastReq()
        req.latitude = NSNumber(value: self.cityCoordinate.latitude)
        req.longitude = NSNumber(value: self.cityCoordinate.longitude)
        req.units = UserDefaults.standard.getDefaultUnit()
        
        WebService.sharedInstance.doCallGetAPI(APIUrl.TodayForcast, params: req.parameters()) { (apiResponse: TodayForcastRes?, result) in
            
            if let error = result.error {
                Utility.showErrorAlertMessage(titleMessage: APIError.title, alertMsg: error.localizedDescription)
                return
            }
            
            
            if let response = apiResponse, response.statusCode == 200 {
                self.lblCityName.text = response.name
                
                if let weather = response.weatherInfo, let firstWeather = weather.first{
                    self.lblDescription.text = firstWeather.main
                }
                if let main = response.main {
                    self.lblTodayTemp.text = StringUtility.getTemperature(temperature: main.temp)
                }
                self.todaysForeCast = response
                
                self.arrWeatherDetailCell = self.buildWeatherDetailCellData(todayResponse: response)
                
                self.tblDetail.reloadData()
            }else {
                Utility.showErrorAlertMessage(titleMessage: APIError.title, alertMsg: APIError.noResponseFound)
                return
            }
        }
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton!){
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension WeatherDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrWeatherDetailCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherDetailCell", for: indexPath) as! WeatherDetailCell
        
        let data = arrWeatherDetailCell[indexPath.row]
        cell.lblLeftTitle.text = data.leftText
        cell.lblRightTitle.text = data.rightText
        cell.lblLeftValue.text = data.leftValue
        cell.lblRightValue.text = data.rightValue
        
        return cell
    }
    
}


extension WeatherDetailVC {
    
    func getSunriseSunsetData(todayResponse: TodayForcastRes) -> WeatherDetailCellData {
        let data = WeatherDetailCellData()
        data.leftText = Texts.sunriseText
        data.rightText = Texts.sunsetText
        
        if let sys = todayResponse.sys {
            data.leftValue = StringUtility.getTime(timeInterval: sys.sunrise!.intValue, isMinute: false)
            data.rightValue = StringUtility.getTime(timeInterval: sys.sunset!.intValue, isMinute: false)
        }
        return data
    }
    
    func getRainChancesHumidityData(todayResponse: TodayForcastRes) -> WeatherDetailCellData {
        let data = WeatherDetailCellData()
        data.leftText = Texts.rainChancesText
        data.rightText = Texts.humidityText
        if let rainObj = todayResponse.rain {
            data.leftValue = StringUtility.getRainChances(rainChances: rainObj.threeHours)
        }else{
            data.leftValue = "0%"
        }
        
        if let mainObj = todayResponse.main {
            data.rightValue = StringUtility.getHumidity(humidity: mainObj.humidity)
        }else {
            data.rightValue = "0%"
        }
        
        return data
    }
    
    func getWindAndFeelsAlikeData(todayResponse: TodayForcastRes) -> WeatherDetailCellData {
        let data = WeatherDetailCellData()
        
        data.leftText = Texts.windText
        data.rightText = Texts.feelLikeText
        
        if let windObj = todayResponse.wind {
            data.leftValue = StringUtility.getWind(degrees: windObj.deg, speed: windObj.speed)
        }else {
            data.leftValue = "-"
        }
        
        if let mainObj = todayResponse.main {
            data.rightValue = StringUtility.getTemperature(temperature: Double(mainObj.temp_max))
        }else{
            data.rightValue = "-"
        }
        
        return data
    }
    
    func getVisibilityPressureData(todayResponse: TodayForcastRes) -> WeatherDetailCellData {
        let data = WeatherDetailCellData()
        data.leftText = Texts.visibilityText
        data.rightText = Texts.pressureText
        data.leftValue = StringUtility.getVisibility(visibility: todayResponse.visibility)
        
        if let main = todayResponse.main {
            data.rightValue = StringUtility.getPresure(presure: main.pressure)
        }else{
            data.rightValue = "-"
        }
        return data
    }
    
     func buildWeatherDetailCellData(todayResponse: TodayForcastRes) -> [WeatherDetailCellData]{
        
        var data = [WeatherDetailCellData]()
        data.append(self.getSunriseSunsetData(todayResponse: todayResponse))
        data.append(self.getRainChancesHumidityData(todayResponse: todayResponse))
        data.append(getWindAndFeelsAlikeData(todayResponse: todayResponse))
        data.append(getVisibilityPressureData(todayResponse: todayResponse))
        
        return data
    }
}
