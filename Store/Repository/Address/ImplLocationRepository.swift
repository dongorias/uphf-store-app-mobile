//
//  ImpLocationRepository.swift
//  Store
//
//  Created by Don Arias Agokoli on 07/02/2025.
//

import Foundation
import CoreLocation

class ImplLocationRepository: NSObject, LocationRepository, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }
    
    func fetchUserLocation(completion: @escaping (Result<CLLocation, Error>) -> Void) {
        locationManager?.startUpdatingLocation()
        
        // Stocker la closure pour l'utiliser dans le delegate
        self.completionHandler = completion
    }
    
    private var completionHandler: ((Result<CLLocation, Error>) -> Void)?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            completionHandler?(.success(location))
            locationManager?.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completionHandler?(.failure(error))
    }
}
