//
//  ViewController.swift
//  GPSTest
//
//  Created by Guillermo Alonso on 22/10/16.
//  Copyright © 2016 Guillermo ALonso. All rights reserved.
//

import UIKit
import CoreLocation //Para usar el gps
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate {

    var localizador:CLLocationManager?
    
    @IBOutlet weak var txtLong: UITextField!
    @IBOutlet weak var txtLat: UITextField!
    
    @IBOutlet weak var elMapa: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.localizador = CLLocationManager()
        self.localizador?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.localizador?.delegate = self
        
        let autorizado = CLLocationManager.authorizationStatus()
        if autorizado == CLAuthorizationStatus.NotDetermined {
            self.localizador?.startUpdatingLocation()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
        self.localizador?.stopUpdatingLocation()
        let ac = UIAlertController(title: "Error", message: "Nose pueden obtener las coordenadas del GPS", preferredStyle: .Alert)
        let ab = UIAlertAction(title: "So sad..", style: .Default, handler: nil)
        ac.addAction(ab)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let ubicacion = locations.last
        self.txtLat.text = "\(ubicacion?.coordinate.latitude)"
        self.txtLong.text = "\(ubicacion?.coordinate.longitude)"
        //TODO: determinar si se dejan de tomar lecturas
        self.colocarMapa(ubicacion!)
    }
    
    func colocarMapa(ubicacion:CLLocation){
        let laCoordenada = ubicacion.coordinate
        let region = MKCoordinateRegionMakeWithDistance(laCoordenada, 1000, 1000)
        self.elMapa.setRegion(region, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

