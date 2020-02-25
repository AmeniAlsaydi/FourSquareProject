//
//  MapViewController.swift
//  FourSquareProject
//
//  Created by Amy Alsaydi on 2/21/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import DataPersistence
import MapKit

class MapViewController: UIViewController {
    
    private var datapersistance: DataPersistence<Venue>
    
    private var mapView = MapView()
    
    private var listView = ListView()
    
    private var isButtonPressed = false
    
    private var venues = [Venue]()
    
    private var isShowingAnnotations = false
    
    private var annotations = [MKAnnotation]()
    
    private let coreLocationSession = CoreLocationSession()
    
    init(_ dataPersistance: DataPersistence<Venue>) {
        self.datapersistance = dataPersistance
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) - error")
    }
    
    override func loadView() {
        view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()

        //mapview
        mapView.collectionView.register(MapViewCell.self, forCellWithReuseIdentifier: "mapViewCell")
        mapView.collectionView.dataSource = self
        mapView.collectionView.delegate = self
        mapView.venueTextField.delegate = self
        mapView.locationTextField.delegate = self
        
        loadVenues(state: "New York", search: "coffee shop")
        mapView.mapKitView.showsUserLocation = true
        
        //listview
        
    }
    
    private func loadVenues(state: String, search: String) {
        VenueApiClient.getVenues(state: state, searchQuery: search) { (result) in
            switch result {
            case .failure(let appError):
                print("error getting data from api \(appError)")
            case .success(let venues):
                self.venues = venues
                self.loadMapView()
            }
        }
    }
   
        private func makeAnnotations() -> [MKPointAnnotation] {
            var annotations = [MKPointAnnotation]()
            
            for venue in venues {
                let annotation = MKPointAnnotation()
                let location = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
                annotation.coordinate = location
                annotation.title = venue.name
                annotations.append(annotation)
            }
            isShowingAnnotations = true
            self.annotations = annotations
            return annotations
        }

    private func loadMapView() {
        let annotations = makeAnnotations()
        mapView.mapKitView.addAnnotations(annotations)
        mapView.mapKitView.showAnnotations(annotations, animated: true)
    }
    
    private func convertPlaceNameToCoordinate(_ placename: String) {
        coreLocationSession.convertPlaceNameToCoordinate(addressString: placename) { (result) in
            switch result {
            case .failure(let error):
                print("geocoding error \(error)")
            case .success(let coordinate):
                let region =  MKCoordinateRegion(center: coordinate, latitudinalMeters: 1600, longitudinalMeters: 1600)
                self.mapView.mapKitView.setRegion(region, animated: true)
            }
        }
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search Venue"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(barButtonPressed(sender:)))
    }
    
    @objc private func barButtonPressed(sender: UIBarButtonItem) {
        isButtonPressed.toggle()
        
        if isButtonPressed {
            view = listView
            sender.image = UIImage(systemName: "mappin.and.ellipse")
            navigationController?.navigationBar.backgroundColor = .white
        } else {
            view = mapView
            sender.image = UIImage(systemName: "list.bullet")
        }
    }

}

extension MapViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mapView.collectionView.dequeueReusableCell(withReuseIdentifier: "mapViewCell", for: indexPath) as? MapViewCell else {
            fatalError("could not cast to mapViewCell")
        }
        cell.backgroundColor = .white
        return cell
    }
}
extension MapViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxsize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxsize.width
        let itemHeight: CGFloat = maxsize.height * 0.20
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension MapViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let searchText = textField.text, !searchText.isEmpty else {
            return true
        }
        
        convertPlaceNameToCoordinate(searchText)
        
        return true
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else {
            return
        }
        guard let venue = (venues.filter {$0.name == annotation.title}).first else {
            return
        }
        
        //TODO: present detail view
        let detailVC = DetailViewController()
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        let identifier = "annotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.glyphImage = UIImage(systemName: "mappin.and.ellispe")
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        if isShowingAnnotations {
            mapView.showAnnotations(annotations, animated: true)
        }
        isShowingAnnotations = false
    }
}
