//
//  ViewController.swift
//  testing
//
//  Created by asun martinez on 23/11/16.
//  Copyright © 2016 asun martinez. All rights reserved.
//

import UIKit
import Parse
import FBSDKLoginKit
import FBSDKCoreKit
import TwitterKit


class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    var irse = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let logo = UIImage(named: "logo1_pequeno.png")
        let logoView = UIImageView(image: #imageLiteral(resourceName: "Logo1_pequeno.png"))
        
        var centerH = (self.view.frame.size.width/2) - (logo?.size.width)!/2
        logoView.frame = CGRect(x: centerH, y: 50, width: (logo?.size.width)!, height: (logo?.size.height)!)
        view.addSubview(logoView)
        
        FBSDKProfile.enableUpdates(onAccessTokenChange: true);
        }
 
    func loginButtonDidLogOut(_ loginButtonFB: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
    func loginButton(_ loginButtonFB: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self){
            (result, err) in
            if err != nil{
                print("El inicio de sesión ha fallado:", err)
                return
            }

            self.showEmailAddress()
        }
        FBSDKProfile.enableUpdates(onAccessTokenChange: true);

        self.performSegue(withIdentifier: "toHomeSegue", sender: nil);

    }
    
    func showEmailAddress() {
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start {
            (connection, result, err) in
            if err != nil{
                print("Failed to start the graph request:", err)
                return
            }
            print(result)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let query: PFQuery = PFQuery(className: "Nanny")
        //query.whereKey("type", equalTo: 1)
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                NSLog("\(objects)")
            } else {
                NSLog("Error: \(error)")
            }
        }
    }
    
    @IBAction func toRegisterView(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toRegisterView", sender: nil)
    }
    
    @IBAction func manualLoginAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toLoginView", sender: nil)
    }
    
    
    @IBAction func loginButtonTw (_sender: UIButton){
        Twitter.sharedInstance().logIn {
            (session, error) -> Void in
            if (session != nil) {
                self.performSegue(withIdentifier: "toHomeSegue", sender: nil)
            } else {
                NSLog("Login error: %@", error!.localizedDescription)
            }
        }
    }
    
    @IBAction func loginButtonFB (_sender: UIButton){
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, err) in
            if err != nil {
                print("Custom FB Login failed:", err)
                return
            }
            FBSDKProfile.enableUpdates(onAccessTokenChange: true);
            
            self.performSegue(withIdentifier: "toHomeSegue", sender: nil);
        }
    }
    

}
