import UIKit
import SwiftLocation
import CoreLocation
import GooglePlaces
class HomeVC: UIViewController {
    
    let dbQueryInstance = CoreDataQuery.sharedInstance
    var cities = [City]()
    var locationDetail = LocationDetail()
    
    @IBOutlet var tblHome: UITableView!
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblHome.tableFooterView = UIView()
        self.initViews()
        self.fetchCitiesInfo()
        self.fetchWeatherInfo()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func initViews(){
        
        self.navigationItem.title = Texts.homeTitle
        let settingButton =  Utility.barButtonItem(selector: #selector(self.btnSettingsTapped), controller: self, image: UIImage(named: "settings")!)
        self.navigationItem.leftBarButtonItem = settingButton
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.btnAddTapped))
        self.navigationItem.rightBarButtonItem = addBarButton
        
        if #available(iOS 10.0, *) {
            tblHome.refreshControl = refreshControl
        } else {
            tblHome.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(self.fetchWeatherInfo), for: .valueChanged)
    }
    
    @IBAction func fetchWeatherInfo(){
        if cities.count > 0 {
            self.fetchDataByCitiesID()
        }
        
    }
    
    func fetchCitiesInfo(){
        let cityRecords = self.dbQueryInstance.fetchAllCities()
        if let cityQueryRecords = cityRecords {
            self.cities = cityQueryRecords
        }
        self.tblHome.reloadData()
    }
    
    @IBAction func btnSettingsTapped(){
        let settingVC = Storyboard.sharedInstance.settingController()
        settingVC.delegate = self
        let nvc = UINavigationController(rootViewController: settingVC)
        self.present(nvc, animated: true) {
        }
    }
    
    @IBAction func btnAddTapped(){
//        let addVC = Storyboard.sharedInstance.addLocationController()
//        addVC.delegate = self
//        self.navigationController?.pushViewController(addVC, animated: true)
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
}
// MARK: - ViewController Navigation {
extension HomeVC {
 
    func pushToWeatherDetailVC(location: CLLocationCoordinate2D){
        let weatherDetailVC = Storyboard.sharedInstance.weatherDetailController()
        weatherDetailVC.cityCoordinate = location
        self.navigationController?.pushViewController(weatherDetailVC, animated: true)
    }
    
    
}
// MARK: - APICalls
extension HomeVC {
    
    func fetchDataByCitiesID(){
        let req = MultipleCityIdReq()
        let citiesId = self.cities.map { "\($0.cityId)" }
        req.id = citiesId.joined(separator: ",")
        req.units = UserDefaults.standard.getDefaultUnit()
        
        WebService.sharedInstance.doCallGetAPI(APIUrl.MultipleCityGroup, params: req.parameters()) { (response: MultipleCityIdRes?, result) in
            
            if let error = result.error {
                Utility.showErrorAlertMessage(titleMessage: APIError.title, alertMsg: error.localizedDescription)
                return
            }
            
            guard let response = response else {
                Utility.showErrorAlertMessage(titleMessage: APIError.title, alertMsg: APIError.noResponseFound)
                return
            }
            
            if let lists = response.list, lists.count > 0 {
                do {
                    
                    for list in lists {
                        
                        let predicate = NSPredicate(format: "cityId == %d", list.id)
                        let records = self.dbQueryInstance.dbManager.fetchRecordsByPredicate(type: City.self, predicate: predicate)
                        
                        if let dbRecords = records, dbRecords.count > 0 {
                            let first = dbRecords.first!
                            try self.dbQueryInstance.updateCityByGroupResponse(city: list, cityRecord: first)
                        }
                        
                        self.fetchCitiesInfo()
                    }
                }catch {
                    print(error.localizedDescription)
                }
                
                self.refreshControl.endRefreshing()
                self.tblHome.reloadData()
            }
        }
    }
    
    func fetchTodayForecast(lat: Double, long: Double){
        let req = TodayForcastReq()
        req.latitude = NSNumber(value: lat)
        req.longitude = NSNumber(value: long)
        req.units = UserDefaults.standard.getDefaultUnit()
        
        
        
        WebService.sharedInstance.doCallGetAPI(APIUrl.TodayForcast, params: req.parameters()) { (apiResponse: TodayForcastRes?, result) in
            
            if let error = result.error {
                Utility.showErrorAlertMessage(titleMessage: "Error", alertMsg: error.localizedDescription)
                return
            }
            
            if let response = apiResponse, response.statusCode == 200 {
                do {
                    
                    let predicate = NSPredicate(format: "cityId == %d", response.id)
                    let records = self.dbQueryInstance.dbManager.fetchRecordsByPredicate(type: City.self, predicate: predicate)
                    
                    if let dbRecords = records, dbRecords.count > 0 {
                        let first = dbRecords.first!
                        try self.dbQueryInstance.updateCity(response: response, categoryDB: first)
                    }else{
                       _ =  try self.dbQueryInstance.insertCity(response: response)
                    }
                    
                    let cityRecords = self.dbQueryInstance.dbManager.fetchRecords(type: City.self)
                    if let cityQueryRecords = cityRecords, cityQueryRecords.count > 0 {
                        self.cities = cityQueryRecords
                    }
                    
                    self.fetchDataByCitiesID()
                    
                    self.tblHome.reloadData()
                    
                }catch{
                    print(error.localizedDescription)
                }
            }else {
                Utility.showErrorAlertMessage(titleMessage: APIError.title, alertMsg: APIError.noResponseFound)
                return
            }
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.cities.count == 0 {
            self.tblHome.setEmptyMessage(Texts.emptyCityText, buttonTitle: Texts.buttonAddlocationTitle, selector: #selector(self.btnAddTapped), target: self)
        } else {
            self.tblHome.restore()
        }
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
        let city = self.cities[indexPath.row]
        print("showing city: " + city.cityName!)
        cell.lblTemp.text  = StringUtility.getTemperature(temperature: city.temperature)
        cell.lblCityName.text = city.cityName
        cell.lblTime.text = StringUtility.getTime(timeInterval: Int(city.updatedTime), isMinute: true)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = self.cities[indexPath.row];
        let coordinate = CLLocationCoordinate2D(latitude: city.latitude, longitude: city.longitude)
        self.pushToWeatherDetailVC(location: coordinate)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.tblHome.beginUpdates()
            try! self.dbQueryInstance.deleteCity(city: cities[indexPath.row])
            self.cities.remove(at: indexPath.row)
            self.tblHome.deleteRows(at: [indexPath], with: .automatic)
            self.tblHome.endUpdates()
        }
    }
}


extension HomeVC: AddLocationDelegate {
    func selectedLocation(locationObject: LocationDetail) {
        self.fetchTodayForecast(lat: locationObject.coordinate.latitude, long: locationObject.coordinate.longitude)
    }
}

extension HomeVC: SettingDelegate {
    func updateHomeController(_ viewController: SettingsVC) {
        self.fetchCitiesInfo()
        self.fetchWeatherInfo()
    }
}


extension HomeVC: GMSAutocompleteViewControllerDelegate {
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        dismiss(animated: true) {
            self.locationDetail.coordinate = place.coordinate
            self.locationDetail.cityName = place.name
            self.selectedLocation(locationObject: self.locationDetail)
            //self.setupMapwith(location: self.locationDetail.coordinate)
            print("selected place is : " + place.name)
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}
