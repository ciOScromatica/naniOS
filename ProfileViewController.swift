//
//  ProfileViewController.swift
//  testing
//
//  Created by Desi Sobrino on 30/11/16.
//  Copyright © 2016 asun martinez. All rights reserved.
//

import UIKit
import Parse
import FBSDKLoginKit
import FBSDKCoreKit
import TwitterKit

class ProfileViewController: UIViewController {
    
   
    
    
    @IBAction func confirmLogOut(_ sender: UIButton) {
        let alert = UIAlertController(title: "Log Out", message: "¿Desea cerrar la sesión?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action) -> Void in self.logOut()})
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) -> Void in
            print ("Se ha seleccionado la acción de cancelar")
        })
        
            alert.addAction(okAction)
            alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        }
    
    
    func logOut(){
        if(usuarioFB()==true){
            FBSDKLoginManager().logOut()
            self.performSegue(withIdentifier: "fromLogOutToMain", sender: nil)
            print("FACEBOOK logout ok")
        }else{
            if(usuarioTW()==true){
                if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
                    Twitter.sharedInstance().sessionStore.logOutUserID(userID)
                }
                self.performSegue(withIdentifier: "fromLogOutToMain", sender: nil)
                print("Twitter logout ok")
            }else{
                if(usuarioMN()==true){
                    PFUser.logOut()
                    self.performSegue(withIdentifier: "fromLogOutToMain", sender: nil)
                    print("manual logout ok")
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


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
