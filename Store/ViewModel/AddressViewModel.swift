//
//  AddressViewModel.swift
//  Store
//
//  Created by Don Arias Agokoli on 07/02/2025.
//

import Foundation
import CoreLocation

class LocationViewModel: ObservableObject {
    @Published var userLocation: CLLocation?
    @Published var locationName: String = ""
    
    private var locationRepository: LocationRepository
    
    init(repository: LocationRepository = ImplLocationRepository()) {
        self.locationRepository = repository
    }
    
    func getUserLocation() {
        locationRepository.fetchUserLocation { result in
            switch result {
            case .success(let location):
                self.userLocation = location
                self.reverseGeocode(location: location)
            case .failure(let error):
                print("Error fetching location: \(error)")
            }
        }
    }
    
    private func reverseGeocode(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Error in reverse geocoding: \(error)")
                return
            }
            if let placemark = placemarks?.first {
                self.locationName = placemark.name ?? "Unknown Location"
            }
        }
    }
}
