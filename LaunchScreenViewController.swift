//
//  LaunchScreenViewController.swift
//  testing
//
//  Created by Desi Sobrino on 30/11/16.
//  Copyright © 2016 asun martinez. All rights reserved.
//

import UIKit
import Fabric
import Parse
import TwitterKit
import FBSDKCoreKit

class LaunchScreenViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Show the home screen after a bit. Calls the show() function.
        let timer = Timer.scheduledTimer(
        timeInterval: 0.1, target: self, selector: #selector(UIAlertView.show), userInfo: nil, repeats: false)
    }
        
    //Gets rid of the status bar//
    override var prefersStatusBarHidden: Bool {
        return true
    }
        
    //Shows the app's main home screen. Gets called by the timer in viewDidLoad()//
    func show() {
        
        if(usuarioFB()==true){
            self.performSegue(withIdentifier: "fromLaunchtoHomeSegue", sender: nil)
            print("FACEBOOK login in appdelegate")
        }else{
            if(usuarioTW()==true){
                self.performSegue(withIdentifier: "fromLaunchtoHomeSegue", sender: nil)                
                print("Twitter login in appdelegate")
            }else{
                if(usuarioMN()==true){
                    self.performSegue(withIdentifier: "fromLaunchtoHomeSegue", sender: nil)
                    print("manual login in appdelegate")
                }else{
                    self.performSegue(withIdentifier: "toMain", sender: self)
                }
            }
        }
    }
    
    func usuarioTW()-> Bool{
        var TW=false
        if( Twitter.sharedInstance().sessionStore.session() != nil){
            TW = true
        }else{
            TW = false
        }
        return TW
    }
    
    func usuarioFB()-> Bool{
        var FB=false
        if(FBSDKAccessToken.current() != nil){
            let accessToken = FBSDKAccessToken.current()
            if (accessToken != nil){
                FB=true
                print ("------------Login correcto con FB----------")
            }else{
                print ("------------Login permanente error----------")
                FB=false
            }
        }
        return FB
    }
    
    func usuarioMN()-> Bool{
        var MN = false
        let current = PFUser.current() //!!!!!!!!!!!!!!!!!ver que sea la misma
        if (current != nil){
            print ("------------Login correcto con MN----------")
            MN = true
        }else{
            print ("------------Login error MN----------")
            MN = false
        }
        return MN;
    }
}
