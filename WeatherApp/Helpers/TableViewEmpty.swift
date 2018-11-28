
import Foundation
import UIKit

extension UITableView {
    
    func setEmptyMessage(_ message: String, buttonTitle: String, selector: Selector, target: UIViewController) {
        
        let vwEmpty = UIView(frame: CGRect(x: 0, y: 0, width: target.view.frame.size.width, height: self.bounds.size.height))
        vwEmpty.backgroundColor = UIColor.clear
        
        let messageLabel = UILabel(frame: CGRect(x: 16, y: vwEmpty.center.y, width: target.view.frame.size.width - 32, height: Device.IS_IPAD ? 70:50))
        messageLabel.text = message
       
        messageLabel.center.x = vwEmpty.center.x
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        
        messageLabel.font = UIFont.systemFont(ofSize: Device.IS_IPAD ? 25.0:19.0)
        
        vwEmpty.addSubview(messageLabel)
        
        let button:UIButton = UIButton(frame: CGRect(x: 32, y: messageLabel.frame.origin.y + messageLabel.frame.size.height + 20
            , width: 200, height: 50))
        button.center.x = vwEmpty.center.x
        button.backgroundColor = Colors.navigationBarColor
        button.setTitle(buttonTitle, for: .normal)
        button.addTarget(target, action: selector, for: .touchUpInside)
       
        vwEmpty.addSubview(button)
        
        self.backgroundView = vwEmpty;
        self.separatorStyle = .none;
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
