//
//  LoginViewController.swift
//  testing
//
//  Created by asun martinez on 30/11/16.
//  Copyright © 2016 asun martinez. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPasswordLog: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let logo = UIImage(named: "Logo1_pequeno")
        let logoView = UIImageView(image: logo!)
        
        let centerH = (self.view.frame.size.width/2) - (logo?.size.width)!/2
        //var centerText = self.view.frame.size.width/2
        logoView.frame = CGRect(x: centerH, y: 50, width: (logo?.size.width)!, height: (logo?.size.height)!)
        view.addSubview(logoView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        let userName = self.tfUserName.text
        let password = self.tfPasswordLog.text
        
        // Run a spinner to show a task in progress
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0,y: 0,width: 150,height: 150)) as UIActivityIndicatorView
         spinner.startAnimating()
        
        // Send a request to login
        
        PFUser.logInWithUsername(inBackground: userName!, password: password!, block: { (user, error) -> Void in
            if (user != nil){
                print("Estas conectado")
                self.performSegue(withIdentifier: "toHomeView", sender: nil)
                
            }else{
                print("no estas conectado", error)
            }
        })
        
        spinner.stopAnimating()
    }
}
