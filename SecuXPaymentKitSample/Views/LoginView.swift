//
//  LoginView.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/11.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit
import secux_paymentkit_v2

import LocalAuthentication

public protocol LoginViewDelegate{
    func showLoginMessage(message:String)
    func loginStart()
    func loginDone(ret:Bool, errorMsg:String)
}

class LoginView: UIView{
    
    let maxInputFieldLen: CGFloat = 400
    var inputBoxOffset = 30.0
    var loginDelegate : LoginViewDelegate?
    
    lazy var emailInput: IconUITextField = {
     
        let input = IconUITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        //input.borderStyle = .roundRect
        //input.keyboardType = UIKeyboardType.namePhonePad
        input.keyboardType = UIKeyboardType.emailAddress
        input.returnKeyType = .done
        
        //input.placeholder = "Email"
        input.attributedPlaceholder = NSAttributedString(string: "Name",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                                                      NSAttributedString.Key.font: UIFont(name: "Arial", size: 17.0)!])
        
        //input.layer.masksToBounds = true
        //input.layer.cornerRadius = 5.0
        
        //input.backgroundColor = .white //#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
        //input.textColor = UIColor.darkGray
        //input.leftImage = UIImage(named: "accountIcon")
        
        input.backgroundColor = .clear
        input.textColor = .white
        input.layer.borderColor = UIColor.white.cgColor
        input.layer.borderWidth = 1
        
        input.tintColor = .white
        
        
        input.leftPadding = 5
        input.font = UIFont(name: "Arial", size: 19.0)
        
        
        self.addSubview(input)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                input.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
                input.widthAnchor.constraint(equalToConstant: maxInputFieldLen),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        }else{
            NSLayoutConstraint.activate([
                
                input.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
                input.leftAnchor.constraint(equalTo: self.leftAnchor, constant: CGFloat(inputBoxOffset)),
                input.rightAnchor.constraint(equalTo: self.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                
                //input.widthAnchor.constraint(equalToConstant: 200),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        }
        
        
        return input
    }()
    
    lazy var pwdInput: IconUITextField = {
       
        let input = IconUITextField()
        
        //let input = IconUITextField(frame: rect)
        input.translatesAutoresizingMaskIntoConstraints = false
        
        //input.borderStyle = .roundRect
        input.keyboardType = UIKeyboardType.alphabet
        input.returnKeyType = .done
        
        input.attributedPlaceholder = NSAttributedString(string: "Password",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                                         NSAttributedString.Key.font: UIFont(name: "Arial", size: 17.0)!])
        
        
        //input.cornerRadius = 60
        //input.layer.masksToBounds = true
        //input.layer.cornerRadius = 5.0
        
        //input.backgroundColor = .white //#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
        //input.textColor = UIColor.darkGray
        
        input.backgroundColor = .clear
        input.textColor = .white
        input.layer.borderColor = UIColor.white.cgColor
        input.layer.borderWidth = 1
        input.tintColor = .white
        
        input.isSecureTextEntry = true
        //input.leftImage = UIImage(named: "pwdIcon")
        input.leftPadding = 5
        input.font = UIFont(name: "Arial", size: 19.0)
        
        
        
        self.addSubview(input)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                input.topAnchor.constraint(equalTo: self.emailInput.bottomAnchor, constant: 30),
                input.widthAnchor.constraint(equalToConstant: maxInputFieldLen),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        }else{
            NSLayoutConstraint.activate([
                
                input.topAnchor.constraint(equalTo: self.emailInput.bottomAnchor, constant: 30),
                input.leftAnchor.constraint(equalTo: self.leftAnchor, constant: CGFloat(inputBoxOffset)),
                input.rightAnchor.constraint(equalTo: self.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                input.widthAnchor.constraint(lessThanOrEqualToConstant: self.maxInputFieldLen)
                
            ])
        }
        
        return input
    }()
    
    lazy var biometricLoginButton: UIButton = {
       
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false

        
        let btnAttributes: [NSAttributedString.Key: Any] = [
                            .font: UIFont(name: "Arial", size: 17)!,
                            .foregroundColor: UIColor.white,
                            .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let btnAttributesHighlighted: [NSAttributedString.Key: Any] = [
                            .font: UIFont(name: "Arial", size: 17)!,
                            .foregroundColor: UIColor.gray,
                            .underlineStyle: NSUnderlineStyle.single.rawValue]
        
     
        
        let attributeString = NSMutableAttributedString(string: "Use TouchID / FaceID login",
                                                        attributes: btnAttributes)
        
        
        btn.setAttributedTitle(attributeString, for: .normal)
        btn.setAttributedTitle(NSMutableAttributedString(string: "Use FingerID / FaceID login",
                                                        attributes: btnAttributesHighlighted), for: .highlighted)
        
        btn.addTarget(self, action: #selector(biometricLoginAction), for: .touchUpInside)
        

        self.addSubview(btn)

        NSLayoutConstraint.activate([
           
            btn.topAnchor.constraint(equalTo: self.pwdInput.bottomAnchor, constant: 20),
            btn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
           
        ])

        return btn
    }()
    
    
    lazy var loginButton:  UIRoundedButtonWithGradientAndShadow = {
        
        let btn = UIRoundedButtonWithGradientAndShadow(gradientColors: [UISetting.shared.buttonColor, UISetting.shared.buttonColor])
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleLabel?.font = UIFont(name: UISetting.shared.boldFontName, size: 17)
        btn.setTitle(NSLocalizedString("LOGIN", comment: ""), for: .normal)
        btn.setTitleColor(UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 2
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowOpacity = 0.3
        
        
        self.addSubview(btn)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                btn.topAnchor.constraint(equalTo: self.pwdInput.bottomAnchor, constant: 30),
                btn.widthAnchor.constraint(equalToConstant: self.maxInputFieldLen),
                btn.heightAnchor.constraint(equalToConstant: 45),
                btn.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        }else{
            NSLayoutConstraint.activate([
                
                btn.topAnchor.constraint(equalTo: self.biometricLoginButton.bottomAnchor, constant: 30),
                btn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: CGFloat(inputBoxOffset)),
                btn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                btn.heightAnchor.constraint(equalToConstant: 45),
                btn.centerXAnchor.constraint(equalTo: self.centerXAnchor)
             
                
            ])
        }
       
        return btn
    }()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //self.backgroundColor = UISetting.shared.titleBKColor
        self.backgroundColor = UIColor(white: 1, alpha: 0)
        
        let _ = self.pwdInput
        let _ = self.emailInput
        let _ = self.loginButton
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
        
        if Setting.shared.loginPwd.count > 0, Setting.shared.loginAccount.count > 0{
            self.biometricLoginButton.isHidden = false
            
            
            self.biometricLoginAction()
            
        }else{
            self.biometricLoginButton.isHidden = true
            self.setFocus()
        }
    }
    
    @objc func biometricLoginAction(){
        let localAuthContext = LAContext()
        if localAuthContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil){
            
            let biometricType = localAuthContext.biometryType == LABiometryType.faceID ? "Face ID" : "Touch ID"
            logw("Supported Biometric type is: \( biometricType )")
            
            localAuthContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Auto login the account") { success, evaluateError in
                
                if success{
                    self.autoLogin()
                }
            }
        }
    }
    
    @objc func loginButtonTapped(){
        
        //if !Setting.shared.hasInternet.value{
        //    self.loginDelegate?.showLoginMessage(message: "No network! Please check your phone's network setting.")
       //     return
        //}
        
        
        guard let email = self.emailInput.text, email.count > 0 else{
            self.loginDelegate?.showLoginMessage(message: "Invalid account name!")
            return
        }
        
        guard let pwd = self.pwdInput.text, pwd.count > 0 else{
            self.loginDelegate?.showLoginMessage(message: "Invalid password!")
            return
        }
        
        
        self.loginDelegate?.loginStart()
        DispatchQueue.global(qos: .default).async {
            
            let accManager = SecuXAccountManager()
            accManager.setBaseServer(url: "https://pmsweb-sandbox.secuxtech.com")
            let (ret, data) = accManager.loginMerchantAccount(accountName: email, password: pwd)
        
            if ret == SecuXRequestResult.SecuXRequestOK{
                
                Setting.shared.loginAccount = email
                Setting.shared.loginPwd = pwd
                Setting.shared.saveSetting()
                self.loginDelegate?.loginDone(ret: true, errorMsg: "")
                
                    
            }else{
                
                DispatchQueue.main.async {
                    self.emailInput.shake()
                    self.pwdInput.shake()
                }
                
                var errorMsg = "Invalid email/password!"
                if let data = data, let error = String(data: data, encoding: String.Encoding.utf8){
                    errorMsg = error
                }
                self.loginDelegate?.loginDone(ret: false, errorMsg: "Login failed! \(errorMsg)")
            }
        }
            
    }
    
    public func reset(){
        self.emailInput.text = ""
        self.pwdInput.text = ""
    }
    
    public func setBackgrounImg(){
        
        print("\(self.bounds.width), \(self.bounds.height)")
        
        UIGraphicsBeginImageContext(frame.size)
        UIImage(named: "LoginBackgroundImg")?.draw(in: self.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let image = image{
            self.backgroundColor = UIColor.init(patternImage: image)
        }
    }
    
    public func autoLogin(){
        DispatchQueue.main.async{
            
            self.emailInput.text = Setting.shared.loginAccount
            self.pwdInput.text = Setting.shared.loginPwd
            
            self.loginButtonTapped()
            
        }
        
    }
    
    func setFocus(){
        self.emailInput.becomeFirstResponder()
    }
    
    
}
