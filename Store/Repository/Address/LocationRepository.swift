//
//  LocationRepository.swift
//  Store
//
//  Created by Don Arias Agokoli on 07/02/2025.
//

import Foundation
import CoreLocation

protocol LocationRepository {
    func fetchUserLocation(completion: @escaping (Result<CLLocation, Error>) -> Void)
}
