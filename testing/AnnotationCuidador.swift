//
//  AnnotationCuidador.swift
//  testing
//
//  Created by asun martinez on 26/11/16.
//  Copyright © 2016 asun martinez. All rights reserved.
//

import Foundation
import MapKit

class AnnotationCuidador : NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var myCoordinate: CLLocationCoordinate2D
    var mypuntuacion: Int?
    var edad: Int?
    var nacionalidad: String?
    
    
    
    init(title: String, myCoordinate: CLLocationCoordinate2D, mypuntuacion: Int, edad: Int, nacionalidad: String ) {
        self.title = title
        self.myCoordinate = myCoordinate
        self.mypuntuacion = mypuntuacion
        self.edad = edad
        self.nacionalidad = nacionalidad
    }
    
    var coordinate: CLLocationCoordinate2D {
        return myCoordinate
    }
    var puntuacion: Int{
        return mypuntuacion!
    }
}
