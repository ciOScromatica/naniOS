//
//  RegistroViewController.swift
//  testing
//
//  Created by asun martinez on 29/11/16.
//  Copyright © 2016 asun martinez. All rights reserved.
//

import UIKit
import Parse

class RegistroViewController: UIViewController {
    
    
    @IBOutlet weak var tfName: UITextField!
    
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var tfMail: UITextField!
    
    @IBOutlet weak var tfPhone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerAccion(_ sender: UIButton) {
        
        let newUser = PFUser()
        
        newUser.username = self.tfName.text
        newUser.password = self.tfPassword.text
        newUser.email = self.tfMail.text
        newUser["phone"] = self.tfPhone.text
        
        print(newUser)
        
        
         let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0,y: 0,width: 150,height: 150)) as UIActivityIndicatorView
         spinner.startAnimating()
         spinner.stopAnimating()
        
        
        newUser.signUpInBackground (block: { (succeed, error) -> Void in
            if let error = error {
                //let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
                print("Ha habido error", error)
            } else {
                // Hooray! Let them use the app now.
                print("Me he registrado")
                self.dismiss(animated: true, completion: nil)
                /*let alertOk = UIAlertController(title: "", message: "Registro realizado con éxito", preferredStyle: .alert)
                 
                 let defaultAction = UIAlertAction (title: "OK", style: .default, handler: {(action) -> Void in
                 self.dismiss(animated: true, completion: nil)
                 })
                 alertOk.addAction(defaultAction)*/
            }
        })
        
        spinner.stopAnimating()
    }
    
    
}
