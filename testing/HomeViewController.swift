//
//  HomeViewController.swift
//  testing
//
//  Created by asun martinez on 23/11/16.
//  Copyright © 2016 asun martinez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class HomeViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, HandleMapSearch {

    let locationManager = CLLocationManager();
    let mapaView = MKMapView();
    var resultSearchController:UISearchController? = nil
    //let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(addTapped))
    var selectedPin:MKPlacemark? = nil
    
    //creacion de variable de goblal para mantener el tipo de Nanny cuando se vaya a la vista detalle
    var tipoNanny = 0
    
    //creación de variable que permite conservar la coordenadas de búsqueda para la query
    var locationSearch = CLLocationCoordinate2D()
    var primeraCarga = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addMapTrackingButton()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true);
        
        //creamos la vista del mapa
        let leftMargin:CGFloat = 0
        let topMargin:CGFloat = 0
        let mapWidth:CGFloat = view.frame.size.width
        let mapHeight:CGFloat = view.frame.size.height
        mapaView.frame = CGRect(x:leftMargin,y:topMargin,width:mapWidth,height:mapHeight)

        mapaView.mapType = MKMapType.standard
        mapaView.isZoomEnabled = true
        mapaView.isScrollEnabled = true
        
        view.addSubview(mapaView)
        
        
    }
    
    func addMapTrackingButton(){
        let image = UIImage(named: "TrackingButton.png") as UIImage?
        let buttonGeo = UIButton(type: UIButtonType.system) as UIButton
        buttonGeo.frame = CGRect(x: 20, y: 70, width: 35, height: 35)
        buttonGeo.setImage(image, for: .normal)
        buttonGeo.backgroundColor = .clear
        buttonGeo.addTarget(self, action: #selector(HomeViewController.centerMapOnUserButtonClicked), for:.touchUpInside)
        self.mapaView.addSubview(buttonGeo)
        
    }

    func centerMapOnUserButtonClicked() {
        locationSearch = self.locationManager.location!.coordinate
        self.mapaView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        self.searchCuidador(tipo: tipoNanny, localizacion: locationSearch)
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        let span : MKCoordinateSpan = MKCoordinateSpanMake(0.02, 0.02)
        
        //para establecer la region por distancia
        //mapaView.setRegion(MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 300000, 300000), animated: true);
        
        let region : MKCoordinateRegion = MKCoordinateRegionMake(userLocation.coordinate, span);
        mapaView.setRegion(region, animated: true);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true);
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
        
        mapaView.showsUserLocation = true;
        mapaView.delegate = self;
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "SearchBarTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit() //Esto se puede modificar para que quepa al lado el botón de volver a centrar el mapa.
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(addTapped))

        navigationItem.setRightBarButton(filterButton, animated: true)
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapaView
        locationSearchTable.handleMapSearchDelegate = self
        
        mapaView.removeAnnotations(mapaView.annotations)
        if (!primeraCarga){
            primeraCarga = true;
            locationSearch = self.locationManager.location!.coordinate
            tipoNanny = 0
        }
        let serverConnect = Serverconnect()
        var arrayCuidadores = serverConnect.leerDatosPosTipo(lat: locationSearch.latitude, lon: locationSearch.longitude, tipo: tipoNanny)
        var arrayAnnotation = [AnnotationCuidador]()

        for cuid in arrayCuidadores{
            
            var annotation = AnnotationCuidador(title: cuid.nombre, myCoordinate: cuid.locationCuidador, mypuntuacion: cuid.puntuacion, edad: cuid.edad!, nacionalidad: cuid.nacionalidad!)
            annotation.subtitle = "Puntuación: " + String(cuid.puntuacion)+"/5"
            
            
            arrayAnnotation.append(annotation)
        }
        
        mapaView.addAnnotations(arrayAnnotation)
    }
    
    func addTapped(sender: UIBarButtonItem){
        print("sale el UIBarButtonItem")
        
        
        let filterAlert = UIAlertController(title: "", message: "¿Qué servicios desea?", preferredStyle: .actionSheet)
        
        let kidsSelection = UIAlertAction(title: "Niños", style: .default, handler: {(action) -> Void in
            self.tipoNanny = 1;
            self.searchCuidador(tipo: self.tipoNanny, localizacion: self.locationSearch)
            print("Se ha seleccionado niños")
            })
        
        let olderSelection = UIAlertAction(title: "Personas Mayores", style: .default, handler: {(action) -> Void in
            print ("Se ha seleccionado personas mayores")
            self.tipoNanny = 2
            self.searchCuidador(tipo: self.tipoNanny, localizacion: self.locationSearch)
            })
        
        let bothSelection = UIAlertAction(title: "Ambos", style: .default, handler: {(action) -> Void in
            print ("Se ha seleccionado personas mayores")
            self.tipoNanny = 0
            self.searchCuidador(tipo: self.tipoNanny, localizacion: self.locationSearch)
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) -> Void in
            print ("Se ha seleccionado la acción de cancelar")
            })
        
        filterAlert.addAction(kidsSelection)
        filterAlert.addAction(olderSelection)
        filterAlert.addAction(cancelButton)
        filterAlert.addAction(bothSelection)
        
        present(filterAlert, animated: true, completion: nil)
    }

    func searchCuidador(tipo:Int,localizacion:CLLocationCoordinate2D){
        
        mapaView.removeAnnotations(mapaView.annotations)
        let cuidador = Serverconnect();
        var arrayCuidadores = cuidador.leerDatosPosTipo(lat: localizacion.latitude, lon: localizacion.longitude, tipo: tipo)
        //      self.mapView.clear()
        if(arrayCuidadores != nil){
            var arrayAnnotation = [AnnotationCuidador]()
            for cuid in arrayCuidadores{
                
                var annotation = AnnotationCuidador(title: cuid.nombre, myCoordinate: cuid.locationCuidador, mypuntuacion: cuid.puntuacion, edad: cuid.edad!, nacionalidad: cuid.nacionalidad!)
                annotation.subtitle = "Valoración:" + String(cuid.puntuacion)
                
                arrayAnnotation.append(annotation)
            }
            
            self.mapaView.addAnnotations(arrayAnnotation)
        }
        
    }

    private func locationManager(manager:CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("didChangeAuthorizationStatus");
        
        switch status {
        case .notDetermined:
            print(".NotDetermined");
            locationManager.requestAlwaysAuthorization();
            break
            
        case .authorized:
            print(".Authorized")
            locationManager.startUpdatingLocation();
            break
            
        case .denied:
            print(".Denied");
            locationManager.requestAlwaysAuthorization();
            break
            
        default:
            print("Unhandled authorization status");
            break
        }
    }
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: (error)")
    }
   
    
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapaView.removeAnnotations(mapaView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "(city) (state)"
        }
        //mapaView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.02, 0.02)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapaView.setRegion(region, animated: true)
        locationSearch = region.center
        self.searchCuidador(tipo: tipoNanny, localizacion: locationSearch)
    }
    
    
    // cambia de color el marcador en el mapa

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if (annotation is MKUserLocation){
            return nil;
        }
        
        let reuseId = "pin"
        
        var annotationView = MKPinAnnotationView();
        if let dequeuedView = mapaView.dequeueReusableAnnotationView(withIdentifier: reuseId){
            annotationView = dequeuedView as! MKPinAnnotationView;
        }else{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
        }
        
        let customAnnot = annotation as! AnnotationCuidador
        annotationView.pinTintColor = pinColor(num: customAnnot.puntuacion)
        annotationView.canShowCallout = true
        
        let rightButton: AnyObject! = UIButton.init(type: UIButtonType.detailDisclosure)
        annotationView.rightCalloutAccessoryView = rightButton as! UIView
        
        return annotationView;
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            print(view.annotation?.title)
            self.performSegue(withIdentifier: "toDetailSegue", sender: view.annotation)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "toDetailSegue"){
            let detailView: DetailViewController = segue.destination as! DetailViewController
            
            detailView.loadData(datoARecoger: sender as! AnnotationCuidador)
        }
    }
    
    func pinColor(num:Int) -> UIColor{
        var color = UIColor.purple
        switch num{
        case 1:
            color = UIColor.red
        case 2:
            color = UIColor.yellow
        case 3:
            color = UIColor.orange
        case 4:
            color = UIColor.green
        default:
            color = UIColor.blue
        }
        return color
    }

}
