//
//  Cuidador.swift
//  testing
//
//  Created by asun martinez on 26/11/16.
//  Copyright © 2016 asun martinez. All rights reserved.
//

import Foundation
import CoreLocation


class Cuidador{
    
    var id : String = "";
    var nombre : String = "";
    var puntuacion : Int = 0;
    var locationCuidador : CLLocationCoordinate2D!;
    var edad: Int?
    var nacionalidad: String?
    var type: Int!
    
    init(){
        
    }
    
    init(nombre : String, puntuacion : Int, locationCuidador : CLLocationCoordinate2D, edad: Int, nacionalidad: String) {
        self.nombre = nombre;
        self.puntuacion = puntuacion;
        self.locationCuidador = locationCuidador;
        self.edad = edad;
        self.nacionalidad = nacionalidad;
    }
    
    func cuidadoresCercanosInicio() -> [Cuidador]{
        var arrayCuidadores = [Cuidador()]
        
        
        var arrayServicios: [CLLocationCoordinate2D] = []
        
        for num in 0...10 {
           // var lat = Double()
           // var longt = Double()
           
            var lat = randomBetweenNumbers(firstNum: 39.576, secondNum: 39.599)
            var longt = randomBetweenNumbers(firstNum: 2.649, secondNum: 2.949)
                //var lat = Double(arc4random_uniform(5)+38)
                //var longt = Double(arc4random_uniform(5)+1)
                
                let mark = CLLocationCoordinate2D(latitude: lat, longitude: longt);
                
                arrayServicios.append(mark);
            
        }
        var cuid1 = Cuidador(nombre: "Ana Percha", puntuacion: 4, locationCuidador: arrayServicios[0], edad: 28, nacionalidad: "España")
        var cuid2 = Cuidador(nombre: "Amaya Actriz", puntuacion: 4, locationCuidador: arrayServicios[1], edad: 28, nacionalidad: "España")
        var cuid3 = Cuidador(nombre: "Angelica DaviniaDoe", puntuacion: 3, locationCuidador: arrayServicios[2], edad: 27, nacionalidad: "España")
        var cuid4 = Cuidador(nombre: "Desi Blue", puntuacion: 2, locationCuidador: arrayServicios[3], edad: 26, nacionalidad: "España")
        var cuid5 = Cuidador(nombre: "Sun Sun", puntuacion: 1, locationCuidador: arrayServicios[4], edad: 31, nacionalidad: "España")
        var cuid6 = Cuidador(nombre: "Felix Muñon", puntuacion: 3, locationCuidador: arrayServicios[5], edad: 38, nacionalidad: "España")
        var cuid7 = Cuidador(nombre: "David Topo", puntuacion: 5, locationCuidador: arrayServicios[6], edad: 35, nacionalidad: "España")
        var cuid8 = Cuidador(nombre: "Maria Donet", puntuacion: 2, locationCuidador: arrayServicios[7], edad: 28, nacionalidad: "España")
        var cuid9 = Cuidador(nombre: "Borja iOS", puntuacion: 5, locationCuidador: arrayServicios[8], edad: 36, nacionalidad: "España")
        var cuid10 = Cuidador(nombre: "Nico Aratech", puntuacion: 1, locationCuidador: arrayServicios[9], edad: 34, nacionalidad: "España")
        var cuid11 = Cuidador(nombre: "Antonio Fuerte", puntuacion: 4, locationCuidador: arrayServicios[10], edad: 43, nacionalidad: "España")

        arrayCuidadores.append(cuid1);
        arrayCuidadores.append(cuid2);
        arrayCuidadores.append(cuid3);
        arrayCuidadores.append(cuid4);
        arrayCuidadores.append(cuid5);
        arrayCuidadores.append(cuid6);
        arrayCuidadores.append(cuid7);
        arrayCuidadores.append(cuid8);
        arrayCuidadores.append(cuid9);
        arrayCuidadores.append(cuid10);
        arrayCuidadores.append(cuid11);
        
        
        return arrayCuidadores;

    }
    
    func cuidadoresCercanos(ciudad: String) -> [Cuidador]{
        var arrayCuidadores: [Cuidador] = []
        //Madrid 40.457597, -3.708734
        //Zaragoza 41.656287, -0.888460
        //Palma de Mallorca, Islas Baleares 39.576220, 2.649160
        
        var arrayServicios: [CLLocationCoordinate2D] = []
        
        for num in 0...10 {
            var lat = Double()
            var longt = Double()
            if(ciudad == "iniciar"){
                lat = randomBetweenNumbers(firstNum: 39.576, secondNum: 39.599)
                longt = randomBetweenNumbers(firstNum: 2.649, secondNum: 2.949)
                //var lat = Double(arc4random_uniform(5)+38)
                //var longt = Double(arc4random_uniform(5)+1)
                
                let mark = CLLocationCoordinate2D(latitude: lat, longitude: longt);
                
                arrayServicios.append(mark);
            }
            if (ciudad == "Madrid"){
                lat = randomBetweenNumbers(firstNum: 40.157, secondNum: 40.957)
                longt = randomBetweenNumbers(firstNum: -3.108, secondNum: -3.999)
            //var lat = Double(arc4random_uniform(5)+38)
            //var longt = Double(arc4random_uniform(5)+1)
            
            let mark = CLLocationCoordinate2D(latitude: lat, longitude: longt);
            
            arrayServicios.append(mark);
            }
            if (ciudad == "Zaragoza"){
                lat = randomBetweenNumbers(firstNum: 41.156, secondNum: 41.956)
                longt = randomBetweenNumbers(firstNum: -0.188, secondNum: -0.988)
                //var lat = Double(arc4random_uniform(5)+38)
                //var longt = Double(arc4random_uniform(5)+1)
                
                let mark = CLLocationCoordinate2D(latitude: lat, longitude: longt);
                
                arrayServicios.append(mark);
            }
        }
        
        var cuid1 = Cuidador(nombre: "Ana Percha", puntuacion: 4, locationCuidador: arrayServicios[0], edad: 28, nacionalidad: "España")
        var cuid2 = Cuidador(nombre: "Amaya Actriz", puntuacion: 4, locationCuidador: arrayServicios[1], edad: 28, nacionalidad: "España")
        var cuid3 = Cuidador(nombre: "Angelica DaviniaDoe", puntuacion: 3, locationCuidador: arrayServicios[2], edad: 27, nacionalidad: "España")
        var cuid4 = Cuidador(nombre: "Desi Blue", puntuacion: 2, locationCuidador: arrayServicios[3], edad: 26, nacionalidad: "España")
        var cuid5 = Cuidador(nombre: "Sun Sun", puntuacion: 1, locationCuidador: arrayServicios[4], edad: 31, nacionalidad: "España")
        var cuid6 = Cuidador(nombre: "Felix Muñon", puntuacion: 3, locationCuidador: arrayServicios[5], edad: 38, nacionalidad: "España")
        var cuid7 = Cuidador(nombre: "David Topo", puntuacion: 5, locationCuidador: arrayServicios[6], edad: 35, nacionalidad: "España")
        var cuid8 = Cuidador(nombre: "Maria Donet", puntuacion: 2, locationCuidador: arrayServicios[7], edad: 28, nacionalidad: "España")
        var cuid9 = Cuidador(nombre: "Borja iOS", puntuacion: 5, locationCuidador: arrayServicios[8], edad: 36, nacionalidad: "España")
        var cuid10 = Cuidador(nombre: "Nico Aratech", puntuacion: 1, locationCuidador: arrayServicios[9], edad: 34, nacionalidad: "España")
        var cuid11 = Cuidador(nombre: "Antonio Fuerte", puntuacion: 4, locationCuidador: arrayServicios[10], edad: 43, nacionalidad: "España")

        
        arrayCuidadores.append(cuid1);
        arrayCuidadores.append(cuid2);
        arrayCuidadores.append(cuid3);
        arrayCuidadores.append(cuid4);
        arrayCuidadores.append(cuid5);
        arrayCuidadores.append(cuid6);
        arrayCuidadores.append(cuid7);
        arrayCuidadores.append(cuid8);
        arrayCuidadores.append(cuid9);
        arrayCuidadores.append(cuid10);
        arrayCuidadores.append(cuid11);
        
        
        return arrayCuidadores;
    }
    func randomBetweenNumbers(firstNum: Double, secondNum: Double) -> Double{
        return Double(arc4random()) / 0xFFFFFFFF * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
}
