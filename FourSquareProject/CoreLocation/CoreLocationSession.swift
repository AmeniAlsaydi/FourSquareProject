//
//  CoreLocationSession.swift
//  FourSquareProject
//
//  Created by Amy Alsaydi on 2/24/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation
import CoreLocation

class CoreLocationSession: NSObject {
  
  public var locationManager: CLLocationManager
  
  override init() {
    locationManager = CLLocationManager()
    super.init()
    locationManager.delegate = self
    
    // request the user's location
    locationManager.requestAlwaysAuthorization()
    locationManager.requestWhenInUseAuthorization()
    
    // the following keys needs to be added to the info.plist file
    /*
     NSLocationAlwaysAndWhenInUseUsageDescription
     NSLocationWhenInUseUsageDescription
    */
    
    // get updates for user location
    
    // more aggressive solution of GPS data collection
    //locationManager.startUpdatingLocation()
    
    // less aggressive on battery consumption and GPS data collection
    startSignificantLocationChanges()
    
    // startMonitoringRegion()
  }
  
  private func startSignificantLocationChanges() {
    if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
      // not available on the device
      return
    }
    // less aggresive that the startUpdatingLocation() in GPS monitor chanages
    locationManager.startMonitoringSignificantLocationChanges()
  }
  
  public func convertCoordinateToPlacemark(coordinate: CLLocationCoordinate2D) {
    // we will use the CLGeocoder() class for converting coordinate (CLLocationCoordinate2D) to placemark (CLPlacemark)
    
    // we need to create CLLocation
    let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    
    CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
      if let error = error {
        print("reverseGeocodeLocation: \(error)")
      }
      if let firstPlacemark = placemarks?.first {
        print("placemark info: \(firstPlacemark)")
      }
    }
  }
  
    public func convertPlaceNameToCoordinate(addressString: String, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> ()) {
    // coverting an address to a coordinate
    CLGeocoder().geocodeAddressString(addressString) { (placemarks, error) in
      if let error = error {
        completion(.failure(error))
        print("geocodeAddressString: \(error)")
      }
      if let firstPlacemark = placemarks?.first,
        let location = firstPlacemark.location {
        completion(.success(location.coordinate))
        print("place name coordinate is \(location.coordinate)")
      }
    }
  }
  
  // monitor a CLRegion
  // a CLRegion is made up of a center coordinate and a radius in meters
//  private func startMonitoringRegion() {
//    let location = Location.getLocations()[2] // central park
//    let identifier = "monitoring region"
//    let region = CLCircularRegion(center: location.coordinate, radius: 500, identifier: identifier)
//    region.notifyOnEntry = true
//    region.notifyOnExit = false
//    
//    locationManager.startMonitoring(for: region)
//  }
}

extension CoreLocationSession: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print("didUpdateLocations: \(locations)")
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("didFailWithError: \(error)")
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedAlways:
      print("authorizedAlways")
    case .authorizedWhenInUse:
      print("authorizedWhenInUse")
    case .denied:
      print("denied")
    case .notDetermined:
      print("notDetermined")
    case .restricted:
      print("restricted")
    default:
      break
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
    print("didEnterRegion: \(region)")
  }
  
  func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
    print("didExitRegion: \(region)")
  }
}
