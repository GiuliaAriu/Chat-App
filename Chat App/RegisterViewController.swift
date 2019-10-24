//
//  RegisterViewController.swift
//  Chat App
//
//  Created by Giulia Ariu on 02/01/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func registerPressed(_ sender: AnyObject) {
        
        SVProgressHUD.show()

        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            
            if (self.passwordTextfield.text!.count < 6)
            {
                SVProgressHUD.dismiss()
                
                let alert = UIAlertController(title: "Error", message: "Password should be at least 6 characters long!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
            
            if (!self.emailTextfield.text!.contains("@"))
            {
                SVProgressHUD.dismiss()
                
                let alert = UIAlertController(title: "Error", message: "Email format incorrect!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
            
            if error != nil
            {
                print(error!)
            }
            else
            {
                //Registration successful
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
        
    } 

}
