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
    
    private var datapersistance: DataPersistence<Collection>
    
    private var mapView = MapView()
    
    private var listView = ListView()
    
    private var isButtonPressed = false
    
    private var venues = [Venue]() {
        didSet {
            DispatchQueue.main.async {
                self.loadMapView()
                self.mapView.collectionView.reloadData()
            }
            
        }
    }
    private var venuePhotos = [Photo]() {
        didSet {
            DispatchQueue.main.async {
                self.mapView.collectionView.reloadData()
            }
        }
    }
    
    private var isShowingAnnotations = false
    private var annotations = [MKAnnotation]()
    private let coreLocationSession = CoreLocationSession()
    
    init(_ dataPersistance: DataPersistence<Collection>) {
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
        mapView.searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        mapView.mapKitView.showsUserLocation = true
        
        //listview
        listView.tableView.dataSource = self
        listView.tableView.register(TableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        listView.tableView.delegate = self
    }
    
    private func loadVenues(state: String, search: String) {
        VenueApiClient.getVenues(state: state, searchQuery: search) { (result) in
            switch result {
            case .failure(let appError):
                print("error getting data from api \(appError)")
            case .success(let venues):
                self.venues = venues
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
            navigationController?.navigationBar.backgroundColor = .clear
        }
    }
    
    @objc private func searchButtonPressed() {
        guard let locationText = mapView.locationTextField.text else {
            return
        }
        guard let venueText = mapView.venueTextField.text else {
            return
        }
        
        if venueText.isEmpty {
            print("please fill this out")
        } else {
            loadVenues(state: locationText, search: venueText)
            convertPlaceNameToCoordinate(locationText)
        }
        
    }
}

extension MapViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mapView.collectionView.dequeueReusableCell(withReuseIdentifier: "mapViewCell", for: indexPath) as? MapViewCell else {
            fatalError("could not cast to mapViewCell")
        }
        cell.backgroundColor = .white
        let venue = venues[indexPath.row]
        cell.configureCell(venue: venue)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let selectedVenue = venues[indexPath.row]
         let photoID = selectedVenue.id
         
         let detailedVC = DetailViewController(datapersistance, venue: selectedVenue, photoID: photoID)
         navigationController?.pushViewController(detailedVC, animated: true)
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
        return true
    }
}

extension MapViewController: MKMapViewDelegate {
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

extension MapViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = listView.tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell else {
            fatalError("could not downcast to tableViewCell")
        }
        
        let venue = venues[indexPath.row]
        // cell.textLabel?.text = "hello test cells!"
        //        cell.venueLabel.text = "hola!"
        //        cell.venueImage.image = UIImage(systemName: "mic")
        cell.configureTableViewCell(venue: venue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVenue = venues[indexPath.row]
        // instead pass in photoID
        let photoID = selectedVenue.id
        
        
        let detailedVC = DetailViewController(datapersistance, venue: selectedVenue, photoID: photoID)
        navigationController?.pushViewController(detailedVC, animated: true)
    }
}

extension MapViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
