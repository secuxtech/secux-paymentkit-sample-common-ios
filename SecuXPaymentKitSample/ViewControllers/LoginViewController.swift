//
//  LoginViewController.swift
//  SecuXPaymentKitSample
//
//  Created by maochun on 2020/9/24.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit
import LocalAuthentication
import secux_paymentdevicekit

class LoginViewController: BaseViewController {
    

    lazy var theLoginView: LoginView = {
        
        let loginView = LoginView()
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(loginView)
        
        NSLayoutConstraint.activate([
            
            loginView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            loginView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            loginView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            
        ])
        
        return loginView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .black

        self.theLoginView.loginDelegate = self
        
        let _ = SecuXBLEManager.shared
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.title = ""
        
        self.theLoginView.reset()
    }
    
}

extension LoginViewController: LoginViewDelegate{
    func showLoginMessage(message: String) {
        self.showMessageInMainThread(title: message, message: "")
    }
    
    func loginStart() {
        self.showProgress(info: "Login...")
    }
    
    func loginDone(ret: Bool, errorMsg: String) {
    
        DispatchQueue.main.async {
            self.hideProgress()
        
            if ret{
            
                let vc = MainViewController()
                //vc.modalPresentationStyle = .overFullScreen
                //self.present(vc, animated: true)
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else{
                self.showMessage(title: errorMsg, message: "")
            }
        }
    }
}
