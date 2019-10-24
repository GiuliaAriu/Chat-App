//
//  LoginViewController.swift
//  Chat App
//
//  Created by Giulia Ariu on 02/01/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SVProgressHUD


class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func loginPressed(_ sender: AnyObject) {
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            
            if error != nil
            {
                print(error!)
                
                SVProgressHUD.dismiss()
                
                let alert = UIAlertController(title: "Error", message: "Your email or your password are incorrect!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
            else
            {
                //Login successful
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
        
        
    }
    
    
    
    
}


