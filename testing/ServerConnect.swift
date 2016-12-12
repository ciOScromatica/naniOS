//
//  ServerConnect.swift
//  testing
//
//  Created by asun martinez on 30/11/16.
//  Copyright © 2016 asun martinez. All rights reserved.
//

import Foundation
import Parse
import CoreLocation

class Serverconnect{
    func randomBetweenNumbers(firstNum: Double, secondNum: Double) -> Double{
        return Double(arc4random()) / 0xFFFFFFFF * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func crearDatos(){
        var i = 0
        var nombre = ["Felix","Maria","Gonzalo","Adrian","Pablo", "Ricard","Juanma","Vero","Enrique","Alvaro"]
        /*for i in 1...10{
         var lat = randomBetweenNumbers(firstNum: 41.6561, secondNum: 41.6563)
         var longt = -randomBetweenNumbers(firstNum: 0.888459, secondNum: 0.888461)
         
         // var lat = Double(arc4random_uniform(5))+41.656287
         // var longt = Double(arc4random_uniform(5))-0.888460
         var score = Double(arc4random_uniform(3)+1)
         var tip = Double(arc4random_uniform(2))
         
         var point = PFGeoPoint(latitude:lat, longitude:longt)
         var cuidador = PFObject(className:"Nanny")
         cuidador["name"] = nombre[i-1]
         cuidador["score"] = score
         cuidador["location"] = point
         cuidador["age"] = 30
         cuidador["nationality"] = "???"
         cuidador["type"]=tip
         //cuidador["id"] = "\(i) id"
         
         
         print("Guardamos??????")
         cuidador.saveInBackground(block:{ (success: Bool, error: Error?) ->Void in
         if (success) {
         // The object has been saved.
         print("Se salvo")
         } else {
         // There was a problem, check error.description
         print("No se salvo xq \(error)")
         }
         
         })
         
         }*/
        for i in 1...10{
            // var lat = Double(arc4random_uniform(5))+39.576220
            // var longt = Double(arc4random_uniform(5))+2.649160
            var lat = randomBetweenNumbers(firstNum: 39.576, secondNum: 39.599)
            var longt = randomBetweenNumbers(firstNum: 2.649, secondNum: 2.65)
            
            
            var score = Double(arc4random_uniform(3)+1)
            
            var point = PFGeoPoint(latitude:lat, longitude:longt)
            var cuidador = PFObject(className:"Nanny")
            var tip = Double(arc4random_uniform(2))
            cuidador["name"] = nombre[i-1]
            cuidador["score"] = score
            cuidador["location"] = point
            cuidador["age"] = 30
            cuidador["nationality"] = "española"
            //cuidador["id"] = "\(i) id"
            cuidador["type"]=tip
            print("Guardamos??????")
            cuidador.saveInBackground(block:{ (success: Bool, error: Error?) ->Void in
                if (success) {
                    // The object has been saved.
                    print("Se salvo")
                } else {
                    // There was a problem, check error.description
                    print("No se salvo xq \(error)")
                }
                
            })
            
        }
        
    }
    
    func leerDatosPosTipo(lat:Double,lon:Double, tipo:Int)->[Cuidador]{
        var cuidadores = [Cuidador()]
        
        // User's location
        var point = PFGeoPoint(latitude:lat, longitude:lon)
        
         //Create a query for places
         
         // Interested in locations near user.
 
        var query = PFQuery(className:"Nanny")
        
        query.whereKey("location", nearGeoPoint:point, withinKilometers: 5.5)
        
        do {
            let objects = try query.findObjects()
            if (objects != nil) {
                NSLog("\(objects)")
                //var i = 0
                var place = PFObject(className:"Nanny")
                for place  in objects {
                    var cuida = Cuidador()
                    //  cuidadores[i].id=place["id"] as! String
                    cuida.nombre = place["name"] as! String
                    cuida.puntuacion = place ["score"] as! Int
                    let sitio = CLLocationCoordinate2D(latitude: (place["location"] as AnyObject).latitude, longitude:  (place["location"] as AnyObject).longitude)
                    
                    cuida.locationCuidador=sitio
                    cuida.edad=place["age"] as! Int?
                    cuida.nacionalidad=place["nationality"] as! String?
                    cuida.type = place["type"] as! Int?
                    
                    if(cuida.type != nil){
                        if(tipo == 0){
                            cuidadores.append(cuida)
                        }else{
                            if(cuida.type==0){
                                cuidadores.append(cuida)  //cuando pide niño o mayores solo el cero hay que añadirlo pero no lo hacíamos
                            }else if(cuida.type==tipo){
                                cuidadores.append(cuida)
                            }else{
                                print("El cuidado no cumple los requisitos")
                            }
                        }
                    }
                }
                
                if(cuidadores != nil){
                    cuidadores.remove(at: 0)
                }
                
                NSLog("\(cuidadores)")
            } else {
                NSLog("Error: )")
            }
            
        } catch  {
            print("hubo fallos")
        }
        return cuidadores
        
    }
    
    func leerDatosPosTipo(pos:CLLocationCoordinate2D, tipo:Int)->[Cuidador]{
        var cuidadores = [Cuidador()]
        
        
        
        // User's location
        var point = PFGeoPoint(latitude:pos.latitude, longitude:pos.longitude)
        // Create a query for places
        var query = PFQuery(className:"Nanny")
        
        var query2=PFQuery(className:"Nanny")
        query2.whereKey("type", equalTo: tipo)
        // Interested in locations near user.
        var query3 = PFQuery(className:"Nanny")
        query3.whereKey("location", nearGeoPoint:point, withinKilometers: 5.5)
        
        query = PFQuery.orQuery(withSubqueries: [query3, query2])
        
        // Limit what could be a lot of points.
        //query.limit = 10
        // Final list of objects
        
        do {
            let objects = try query.findObjects()
            if (objects != nil) {
                NSLog("\(objects)")
                //var i = 0
                var place = PFObject(className:"Nanny")
                for place  in objects {
                    var cuida = Cuidador()
                    //  cuidadores[i].id=place["id"] as! String
                    cuida.nombre = place["name"] as! String
                    cuida.puntuacion = place ["score"] as! Int
                    let sitio = CLLocationCoordinate2D(latitude: (place["location"] as AnyObject).latitude, longitude:  (place["location"] as AnyObject).longitude)
                    
                    cuida.locationCuidador=sitio
                    cuida.edad=place["age"] as! Int?
                    cuida.nacionalidad=place["nationality"] as! String?
                    cuida.type = place["type"] as! Int?
                    /*if(cuida.tipo==tipo){
                     cuidadores.append(cuida)
                     }else{
                     print("No vale el tipo")
                     }*/
                    cuidadores.append(cuida)
                    print("Se ha leido: "+cuida.nombre)
                    
                    //  NSLog(place.)
                    
                }
                if(cuidadores != nil){
                    cuidadores.remove(at: 0)
                }
                
                NSLog("\(cuidadores)")
            } else {
                NSLog("Error: )")
            }
            
        } catch  {
            print("hubo fallos")
        }
        return cuidadores
        
    }
    
    func leerDatosPos(pos:CLLocationCoordinate2D)->[Cuidador]{
        var cuidadores = [Cuidador()]
        
        // User's location
        var point = PFGeoPoint(latitude:pos.latitude, longitude:pos.longitude)
        // Create a query for places
        var query = PFQuery(className:"Nanny")
        // Interested in locations near user.
        query.whereKey("location", nearGeoPoint:point, withinKilometers: 5.5)
        
        // Limit what could be a lot of points.
        //query.limit = 10
        // Final list of objects
        
        do {
            let objects = try query.findObjects()
            if (objects != nil) {
                NSLog("\(objects)")
                //var i = 0
                var place = PFObject(className:"Nanny")
                for place  in objects {
                    var cuida = Cuidador()
                    //  cuidadores[i].id=place["id"] as! String
                    cuida.nombre = place["name"] as! String
                    cuida.puntuacion = place ["score"] as! Int
                    let sitio = CLLocationCoordinate2D(latitude: (place["location"] as AnyObject).latitude, longitude:  (place["location"] as AnyObject).longitude)
                    
                    cuida.locationCuidador=sitio
                    cuida.edad=place["age"] as! Int?
                    cuida.nacionalidad=place["nationality"] as! String?
                    
                    
                    print("Se ha leido: "+cuida.nombre)
                    cuidadores.append(cuida)
                    //  NSLog(place.)
                    
                }
                cuidadores.remove(at: 0)
                NSLog("\(cuidadores)")
            } else {
                NSLog("Error: )")
            }
            
        } catch  {
            print("hubo fallos")
        }
        
        return cuidadores
    }
    
    
    
    func leerDatosPos(lat:Double,lon:Double)->[Cuidador]{
        var cuidadores = [Cuidador()]
        
        // User's location
        var point = PFGeoPoint(latitude:lat, longitude:lon)
        // Create a query for places
        var query = PFQuery(className:"Nanny")
        // Interested in locations near user.
        query.whereKey("location", nearGeoPoint:point, withinKilometers: 5.5)
        // Limit what could be a lot of points.
        //query.limit = 10
        // Final list of objects
        
        
        do {
            let objects = try query.findObjects()
            if (objects != nil) {
                NSLog("\(objects)")
                //var i = 0
                var place = PFObject(className:"Nanny")
                for place  in objects {
                    var cuida = Cuidador()
                    //  cuidadores[i].id=place["id"] as! String
                    cuida.nombre = place["name"] as! String
                    cuida.puntuacion = place ["score"] as! Int
                    let sitio = CLLocationCoordinate2D(latitude: (place["location"] as AnyObject).latitude, longitude:  (place["location"] as AnyObject).longitude)
                    
                    cuida.locationCuidador=sitio
                    cuida.edad=place["age"] as! Int?
                    cuida.nacionalidad=place["nationality"] as! String?
                    
                    
                    print("Se ha leido: "+cuida.nombre)
                    cuidadores.append(cuida)
                    //  NSLog(place.)
                    
                }
                cuidadores.remove(at: 0)
                NSLog("\(cuidadores)")
            } else {
                NSLog("Error: )")
            }
            
        } catch  {
            print("hubo fallos")
        }
        
        return cuidadores
    }
    
    
    
    //
    func leerDatosPrue()  ->[Cuidador]{
        var cuidadores = [Cuidador()]
        let query: PFQuery = PFQuery(className: "Nanny")
        //query.whereKey("type", equalTo: 1)
        /*query.findObjectsInBackground { (objects, error) in
         if error == nil {
         NSLog("\(objects)")
         //var i = 0
         var place = PFObject(className:"Nanny")
         for place  in objects! {
         var cuida = Cuidador()
         //  cuidadores[i].id=place["id"] as! String
         cuida.nombre = place["name"] as! String
         cuida.puntuacion = place ["score"] as! Int
         let sitio = CLLocationCoordinate2D(latitude: (place["location"] as AnyObject).latitude, longitude:  (place["location"] as AnyObject).longitude)
         
         cuida.locationCuidador=sitio
         cuida.edad=place["age"] as! Int?
         cuida.nacionalidad=place["nationality"] as! String?
         
         
         print("Se ha leido: "+cuida.nombre)
         cuidadores.append(cuida)
         //  NSLog(place.)
         
         }
         NSLog("\(cuidadores)")
         } else {
         NSLog("Error: \(error)")
         }
         }*/
        
        do {
            let objects = try query.findObjects()
            if (objects != nil) {
                NSLog("\(objects)")
                //var i = 0
                var place = PFObject(className:"Nanny")
                for place  in objects {
                    var cuida = Cuidador()
                    //  cuidadores[i].id=place["id"] as! String
                    cuida.nombre = place["name"] as! String
                    cuida.puntuacion = place ["score"] as! Int
                    let sitio = CLLocationCoordinate2D(latitude: (place["location"] as AnyObject).latitude, longitude:  (place["location"] as AnyObject).longitude)
                    
                    cuida.locationCuidador=sitio
                    cuida.edad=place["age"] as! Int?
                    cuida.nacionalidad=place["nationality"] as! String?
                    
                    
                    print("Se ha leido: "+cuida.nombre)
                    cuidadores.append(cuida)
                    //  NSLog(place.)
                    
                }
                cuidadores.remove(at: 0)
                NSLog("\(cuidadores)")
            } else {
                NSLog("Error: )")
            }
            
        } catch  {
            print("hubo fallos")
        }
        return cuidadores
    }
}
