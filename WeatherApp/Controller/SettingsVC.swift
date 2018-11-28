import UIKit

protocol SettingDelegate {
    func updateHomeController(_ viewController: SettingsVC)
}

class SettingsVC: UIViewController {
    
    @IBOutlet var tblSetting: UITableView!
    var delegate: SettingDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        
        // Do any additional setup after loading the view.
    }
    
    func initViews(){
        self.navigationItem.title = Texts.settingTitle
        self.tblSetting.tableFooterView = UIView()

        let backButton =  Utility.barButtonItem(selector: #selector(self.btnBackTapped), controller: self, image: UIImage(named: "back")!)
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @IBAction func btnBackTapped(){
        self.dismiss(animated: true) {
            
        }
    }
    
    func showRemoveCitiesAlert(){
        
        let alertController = UIAlertController(title: Texts.removeAllCitiesTitle, message: Texts.removeAllCitiesDescr, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "YES", style: .default) { (action:UIAlertAction) in
            
            do{
                try CoreDataQuery.sharedInstance.deleteAllCities()
                self.updateHomeControllerfNeeded()
            }catch{
               print(error)
            }
        }
        
        let noAction = UIAlertAction(title: "NO", style: .cancel) { (action:UIAlertAction) in
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showUnitSelectionOptions(){
        let alert = UIAlertController(title: Texts.selectUnitTitle, message: Texts.selectUnitDescr, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: Unit.Standard.rawValue.capitalized, style: .default , handler:{ (UIAlertAction)in
            UserDefaults.standard.setDefaultUnit(value: Unit.Standard)
            self.reloadUnitRow()
            self.updateHomeControllerfNeeded()
        }))
        
        alert.addAction(UIAlertAction(title: Unit.Metric.rawValue.capitalized, style: .default , handler:{ (UIAlertAction)in
            UserDefaults.standard.setDefaultUnit(value: Unit.Metric)
            self.reloadUnitRow()
            self.updateHomeControllerfNeeded()
        }))
        
        alert.addAction(UIAlertAction(title: Unit.Imparical.rawValue.capitalized, style: .default , handler:{ (UIAlertAction)in
            UserDefaults.standard.setDefaultUnit(value: Unit.Imparical)
            self.reloadUnitRow()
            
            self.updateHomeControllerfNeeded()
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
           
        }))
        
        self.present(alert, animated: true, completion: {
     
        })
    }
    
    func reloadUnitRow(){
        self.tblSetting.beginUpdates()
        self.tblSetting.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        self.tblSetting.endUpdates()
    }
    
    func updateHomeControllerfNeeded(){
         self.delegate.updateHomeController(self)
    }
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            guard let cell  =
                tableView.dequeueReusableCell(withIdentifier: "subtitle") else {
                    return UITableViewCell()
            }
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = Texts.unitsLabel
            
            cell.detailTextLabel?.text = UserDefaults.standard.getDefaultUnit()?.isEmpty == true ? Unit.Standard.rawValue.capitalized: UserDefaults.standard.getDefaultUnit()?.capitalized
          
            return cell
            
        } else if indexPath.row == 1 {
            guard let cell  =
                tableView.dequeueReusableCell(withIdentifier: "cell") else {
                    return UITableViewCell()
            }
            cell.textLabel?.text = Texts.removeAllCitiesTitle
            return cell
        }else  {
            guard let cell  =
                tableView.dequeueReusableCell(withIdentifier: "cell") else {
                    return UITableViewCell()
            }
            
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = Texts.howToUseLabel
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if indexPath.row == 0 {
            self.showUnitSelectionOptions()
        }
        else if indexPath.row == 1 {
           self.showRemoveCitiesAlert()
            
        }else if indexPath.row == 2 {
            let helpVC = Storyboard.sharedInstance.helpController()
            self.navigationController?.pushViewController(helpVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}

