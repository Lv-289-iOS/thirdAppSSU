//
//  LoginVC.swift
//  testApp
//
//  Created by Ganna Melnyk on 3/1/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import UIKit

class RCLLoginVC: UIViewController, AuthServiceDelegate {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInOutlet: UIButton!
    @IBOutlet weak var signUpOutlet: UIButton!
    var image = #imageLiteral(resourceName: "logo")
    
    let customAlert = CustomAlertVC(nibName: "CustomAlertVC", bundle: nil)

    @IBAction func signInButton(_ sender: Any) {
        guard let login = loginTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        authentificator.login(login: login, password: password)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        performSegue(withIdentifier: "ToSignUp", sender: self)
    }
    

    var styler = RCLStyler()
    var authentificator = RCLAuthentificator()
    var infoWindow = RCLInfoWindow()
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.Backgrounds.GrayDark
        authentificator.delegate = self
//        let trash = Trash(trashCanId: "uFYf9ltIIloIxWtFiJLf", userIdReportedFull: "CUXMZQRwJD1JfbrjfDEs")
//        FirestoreService.shared.add(for: trash, in: .trash)
//        FirestoreService.shared.getLatestTrashBy(trashCanId: "uFYf9ltIIloIxWtFiJLf") { (trash) in
//            print(trash!)
//        }
        let json = RLCParsingByJSON()
        json.temp()
//        infoWindow.showAlertAction(text: "I test it", controller: self)
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        styler.styleButton(button: signInOutlet)
        styler.styleButton(button: signUpOutlet)
        loginTextField.textType = .emailAddress
        passwordTextField.textType = .password
        loginTextField.initialStyler()
        passwordTextField.initialStyler()
        logoImage.image = image
//        styler.renderImage(view: logoImage, image: image)
//        addView()
        
    }
    
    func addView() {
//        customAlert.modalTransitionStyle = UIModalTransitionStyle.partialCurl
        
        customAlert.modalPresentationStyle = .overCurrentContext
        present(customAlert, animated: true, completion: nil)
        customAlert.errorTextLabel?.text = "Loooool, it's so easy!"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        authentificator.isAUserActive()
    }
    
    func transitionToCust() {
        performSegue(withIdentifier: "ToApp", sender: self)
    }
    
    func transitionToEmpl() {
        performSegue(withIdentifier: "ToEmp", sender: self)
    }
}

extension RCLLoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func hideKeyboardOnTap(_ selector: Selector) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
