import Foundation
import UIKit

class Storyboard {
    static let sharedInstance = Storyboard()
    
    private init() {}
    
    func mainStoryboard() -> UIStoryboard {
        let main = UIStoryboard(name: "Main", bundle: nil)
        return main
    }
    

    
    func weatherDetailController() -> WeatherDetailVC {
        let weatherDetailVC = self.mainStoryboard().instantiateViewController(withIdentifier: "WeatherDetailVC")
        return weatherDetailVC as! WeatherDetailVC
    }
    
    func settingController() -> SettingsVC {
        let settingVC = self.mainStoryboard().instantiateViewController(withIdentifier: "SettingsVC")
        return settingVC as! SettingsVC
    }
    
    func helpController() -> HelpVC {
        let helpVC = self.mainStoryboard().instantiateViewController(withIdentifier: "HelpVC")
        return helpVC as! HelpVC
    }
}
