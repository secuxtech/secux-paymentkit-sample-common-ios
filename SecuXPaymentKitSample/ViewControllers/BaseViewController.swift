//
//  BaseViewController.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/11/8.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import UIKit
import CoreBluetooth
import JGProgressHUD

class BaseViewController: UIViewController {
    
    
    let theProgress  = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        

    }
    
    func hasBLEPermission() -> Bool{
        if #available(iOS 13.1, *) {
            let authStatus = CBPeripheralManager.authorization
            if authStatus == .denied{
                alertPromptAPPSettings(title: "SecuX EvPay wourld like to use Bluetooth",
                                       message: "Please grant Bluetooth permission")
                return false
                
            }
        }else if #available(iOS 13.0, *){
            let authStatus = CBCentralManager().authorization
            if authStatus == .denied{
                alertPromptAPPSettings(title: "SecuX EvPay wourld like to use Bluetooth",
                                     message: "Please grant Bluetooth permission")
                
                return false
              
            }
            
        }else {
            let authStatus = CBPeripheralManager.authorizationStatus()
            if authStatus == .denied{
                alertPromptAPPSettings(title: "SecuX EvPay wourld like to use Bluetooth",
                                     message: "Please grant Bluetooth permission")
                
                return false
            }
        }
        
        return true
    }

    func alertPromptAPPSettings(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert )
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { alert in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
               return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
               UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                   print("Settings opened: \(success)") // Prints true
               })
            }
        })
        present(alert, animated: true, completion: nil)
    }

    
    func showMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMessageInMainThread(title: String, message: String, closeProgress:Bool = false){
        DispatchQueue.main.async {
            self.hideProgress()
            self.showMessage(title: title, message: message)
        }
    }
    
    
    func hideProgress(){
        self.theProgress.dismiss()
    }

    
    func hideProgressInMain(){
        DispatchQueue.main.async {
            self.hideProgress()
        }
        
    }
    
    func showProgress(info: String){
        
        self.theProgress.textLabel.text = info
        self.theProgress.show(in: self.view)
        
    }
    
    func showProgressInMain(info: String){
        
        DispatchQueue.main.async {
            self.showProgress(info: info)
        }
    }
    
    
    func updateProgress(info: String, type:Int = 0){
        DispatchQueue.main.async {
            
            self.theProgress.textLabel.text = info
            
        }
    }
    
 
}

