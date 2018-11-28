
import Foundation

extension UserDefaults{
    
    //MARK: setDefaultUnit
    func setDefaultUnit(value: Unit) {
        set(value.rawValue, forKey: UserDefaultsKeys.unit.rawValue)
        synchronize()
    }
    
    func getDefaultUnit() -> String? {
        guard let value = string(forKey: UserDefaultsKeys.unit.rawValue) else {
            return nil
        }
        if value == Unit.Imparical.rawValue || value == Unit.Metric.rawValue {
            return value
        }
        return ""
    }
}

enum UserDefaultsKeys : String {
    case unit
}
