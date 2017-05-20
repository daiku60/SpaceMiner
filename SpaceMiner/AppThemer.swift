//
//  AppThemer.swift
//  SpaceMiner
//
//  Created by Jordi Serra i Font on 21/4/17.
//  Copyright © 2017 kudai. All rights reserved.
//
//  Created by Jordi Serra on 20/3/17.
//  Copyright Â© 2017 Visual Engineering. All rights reserved.
//

import Foundation
import BSWInterfaceKit

class AppThemer {
    
    static let themer = AppThemer()
    
    func themeApp(_ window: UIWindow) {
        UINavigationBar.appearance().barTintColor = UIColor.mainAppColor
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UIBarButtonItem.appearance().tintColor = .white
        UISwitch.appearance().onTintColor = UIColor.actionColor
        
        window.tintColor = UIColor.navBarColor
    }
    
}

extension UIColor {
    
    static var mainAppColor: UIColor {
        return .black
    }
    
    static var actionColor: UIColor {
        return .white
    }
    
    static var navBarColor: UIColor {
        return .gray
    }
}

extension UIColor {
    convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: a)
    }
}

extension AppThemer {
    
    enum AppFontTypes {
        case fontBasic
        
        var name: String {
            switch self {
            case .fontBasic:
                return "font-basic"
            }
        }
        
        var styler: TextStyler {
            switch self {
            case .fontBasic: return fontBasicStyler
            }
        }
    }
    
    func attributedString(_ string: String, withFontType type: AppFontTypes = .fontBasic, andColor color: UIColor = .black, andSize size: CGFloat) -> NSAttributedString {
        return type.styler.attributedString(string, color: color, forSize: size)
    }
}

private let fontBasicStyler = FontBasicStyler()

private class FontBasicStyler: TextStyler {
    override init() {
        super.init()
        self.preferredFontName = AppThemer.AppFontTypes.fontBasic.name
    }
}

extension TextStyler {
    func attributedString(_ string: String, color: UIColor = UIColor.black, forSize size: CGFloat) -> NSAttributedString {
        
        let font = appFontWithSize(size)
        
        let attributes = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: color,
            ]
        
        return NSMutableAttributedString(string: string, attributes: attributes)
    }
    
    open func appFontWithSize(_ size: CGFloat) -> UIFont {
        
        let font: UIFont = {
            
            let systemFont = UIFont.systemFont(ofSize: size)
            
            guard let preferredFontName = preferredFontName,
                let font = UIFont(name: preferredFontName, size: size) else {
                    return systemFont
            }
            
            return font
        }()
        
        return font
    }
}


extension UIViewController {
    
    var isRootViewController: Bool {
        return navigationController?.viewControllers.first == self
    }
    
    @objc (spm_styleBarWithTitle:)
    func styleBar(withTitle title: String) {
        guard let navigationController = navigationController else {
            fatalError("To style a bar, you need a navigation controller")
        }
        
        navigationItem.titleView = {
            let label = UILabel()
            label.attributedText = AppThemer.themer.attributedString(
                "· \(title) ·".uppercased(),
                withFontType: .fontBasic,
                andColor: .white,
                andSize: 15
            )
            let view = UIView(frame: CGRect(
                x: 0, y: 0,
                width: navigationController.navigationBar.frame.size.width / 2,
                height: navigationController.navigationBar.frame.size.height / 2
            ))
            view.addSubview(label)
            label.centerInSuperview()
            
            return view
        }()
        
        navigationController.navigationBar.isTranslucent = false
    }
    
    @objc (spm_addMenuButtonWithImage:andHandler:)
    func addMenuButton(withImage buttonImage: UIImage, andHandler handler: @escaping ButtonActionHandler) {
        let config = ButtonConfiguration(
            title: "",
            backgroundColor: .clear,
            contentInset: .zero,
            actionHandler: handler
        )
        
        let button = UIButton(buttonConfiguration: config)
        button.setImage(buttonImage, for: .normal)
        //add function for button
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 21, height: 26)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = barButton
        
        self.navigationItem.hidesBackButton = true
    }
}
