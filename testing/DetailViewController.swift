//
//  DetailViewController.swift
//  testing
//
//  Created by asun martinez on 26/11/16.
//  Copyright © 2016 asun martinez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var cuidadorARecibir: AnnotationCuidador!
    
    @IBOutlet weak var tfNombre: UILabel!
    @IBOutlet weak var tfEdad: UILabel!
    @IBOutlet weak var tfNacionalidad: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tfNombre.text = cuidadorARecibir.title
        tfEdad.text = String(describing: cuidadorARecibir.edad!)
        tfNacionalidad.text = cuidadorARecibir.nacionalidad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(datoARecoger: AnnotationCuidador){
        cuidadorARecibir = datoARecoger;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func contratarAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Contratación del servicio", message: "¿Desea confirmar la contratación?", preferredStyle: .alert)
        
         let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action) -> Void in print("you have pressed the ok button")})
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("you have pressed the Cancel button")}
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)

        }
    

}
