//
//  ListingDetailController.swift
//  avenueproperties
//
//  Created by Alex Beattie on 9/25/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit
import AVFoundation
import MapKit

class ListingDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout, MKMapViewDelegate {
    let cellId = "cellId"
    let descriptionId = "descriptionId"
    let headerId = "headerId"
    let titleId = "titleId"
    let mapId = "mapId"
    var player:AVPlayer!
    var playerLayer:AVPlayerLayer!
    
    var mapView:MKMapView!
    let pin = MKPointAnnotation()
    var region: MKCoordinateRegion!

    
    var listing: Listing? {
        didSet {
            if listing?.photos != nil {
                return
            }
//            mapView.mapType = .standard
//            mapView.delegate = self

//                if let lat = listing?.geo?.lat, let lng = listing?.geo?.lng {
//                    let location = CLLocationCoordinate2DMake(lat, lng)
//                    pin.coordinate = location
//                }
//                mapView.addAnnotation(pin)
            

        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        collectionView?.register(ListingSlides.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(TitleCell.self, forCellWithReuseIdentifier: titleId)
        collectionView?.register(AppDetailDescriptionCell.self, forCellWithReuseIdentifier: descriptionId)
        collectionView?.register(MapCell.self, forCellWithReuseIdentifier: mapId)
        collectionView?.showsVerticalScrollIndicator = false
        
        collectionView?.backgroundColor = UIColor.white
        
//        var mapView = MKMapView()
//        let pin = MKPointAnnotation()
//
//        if let lat = listing?.geo?.lat, let lng = listing?.geo?.lng {
//            let location = CLLocationCoordinate2DMake(lat, lng)
//            pin.coordinate = location
//        }
//        mapView.addAnnotation(pin)
//        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, 27500.0, 27500.0)
//        mapView.setRegion(location, animated: t)
        setupNavBarButtons()
      

    }
    func setupNavBarButtons() {
        let movieIcon = UIImage(named: "movie")?.withRenderingMode(.alwaysOriginal)
        let videoButton = UIBarButtonItem(image: movieIcon, style: .plain, target: self, action: #selector(handleVideo))
        navigationItem.rightBarButtonItem = videoButton
    }

  
    func playVideo() {
        
    }
    
    @objc func handleVideo(url:NSURL) {
        print(123)
        
        let vidUrl = listing?.virtualTourUrl
        let url = URL(string:vidUrl!)
        let player = AVPlayer(url: url!)
        
        let playerController = AVPlayerViewController()
        
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleId, for: indexPath) as! TitleCell
//            let theAddress = listing?.address?.full?.capitalized

            cell.listing = listing
            return cell
        }
        if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionId, for: indexPath) as! AppDetailDescriptionCell
            cell.textView.attributedText = descriptionAttributedText()
            return cell
        }
        if indexPath.item == 3 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mapId, for: indexPath) as! MapCell
            cell.mapView.mapType = .standard
            cell.mapView.delegate = self
            if let lat = listing?.geo?.lat, let lng = listing?.geo?.lng {
            
                let location = CLLocationCoordinate2DMake(lat, lng)
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, 27500.0, 27500.0)
                cell.mapView.setRegion(coordinateRegion, animated: true)

                let pin = MKPointAnnotation()
                

                pin.coordinate = location
                pin.title = listing?.address?.full?.capitalized
                if let listPrice = listing?.listPrice {
                    let numberFormatter = NumberFormatter()
                    numberFormatter.numberStyle = .decimal
                    
                    let subtitle = "$\(numberFormatter.string(from: NSNumber(value:(UInt64(listPrice))))!)"
                    pin.subtitle = subtitle
                }

                cell.mapView.addAnnotation(pin)

            }
            
            cell.mapView.addAnnotation(pin)


            
            return cell
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListingSlides
        cell.listing = listing
        return cell
    }
//    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mapId, for: indexPath) as! MapCell
//        cell.listing = listing
//
////        cell.addSubview(mapView)
//
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
//        setupThumbNailImage()
        
        let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
        annoView.pinTintColor = #colorLiteral(red: 0.5137254902, green: 0.8470588235, blue: 0.8117647059, alpha: 1)
        annoView.animatesDrop = true
        annoView.canShowCallout = true
        let swiftColor = #colorLiteral(red: 0.5137254902, green: 0.8470588235, blue: 0.8117647059, alpha: 1)
        annoView.centerOffset = CGPoint(x: 100, y: 400)
        annoView.pinTintColor = swiftColor
        
        // Add a RIGHT CALLOUT Accessory
        let rightButton = UIButton(type: UIButtonType.detailDisclosure)
        rightButton.frame = CGRect(x:0, y:0, width:32, height:32)
        rightButton.layer.cornerRadius = rightButton.bounds.size.width/2
        rightButton.clipsToBounds = true
        rightButton.tintColor = #colorLiteral(red: 0.5137254902, green: 0.8470588235, blue: 0.8117647059, alpha: 1)
        
        annoView.rightCalloutAccessoryView = rightButton
        
        
//        let leftIconView = UIImageView()
//        leftIconView.contentMode = .scaleAspectFill
//        if let thumnailImageName = listing?.photos![0] {
//            leftIconView.image = UIImage(named: thumnailImageName)
//            self.setupThumbNailImage()
//
//        }
//
//
//        let newBounds = CGRect(x:0.0, y:0.0, width:54.0, height:54.0)
//        leftIconView.bounds = newBounds
//        annoView.leftCalloutAccessoryView = leftIconView
        
        
        return annoView
    }
    func goOutToGetMap() {
        
        
        let lat = listing?.geo?.lat
        let lng = listing?.geo?.lng
        let location = CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
        
        let placemark = MKPlacemark(coordinate: location, addressDictionary: nil)
        
        let item = MKMapItem(placemark: placemark)
        item.name = listing?.address?.full?.capitalized
        item.openInMaps (launchOptions: [MKLaunchOptionsMapTypeKey: 2,
                                         MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate: placemark.coordinate),
                                         MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving])
        
        
    }
//    func setupThumbNailImage() {
//        if let thumbnailImageUrl = listing?.photos?.first {
//            leftIconView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
//        }
//    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        
        let alertController = UIAlertController(title: nil, message: "Driving directions", preferredStyle: .actionSheet)
        let OKAction = UIAlertAction(title: "Get Directions", style: .default) { (action) in
            self.goOutToGetMap()
        }
        alertController.addAction(OKAction)
        
        present(alertController, animated: true) {
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        alertController.addAction(cancelAction)
    }

    fileprivate func descriptionAttributedText() -> NSAttributedString {
       
        
//        let theAddress = listing?.address?.full?.capitalized
//         let theAddress = listing?.address?.full?.capitalized
        

//        let attributedText = NSMutableAttributedString(string: theAddress, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
//        let attributedText = NSMutableAttributedString(string: "\(theAddress ?? "")\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        let attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 4)])

        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        
        let range = NSMakeRange(0, attributedText.string.characters.count)
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: range)
        
        if let desc = listing?.remarks {
            attributedText.append(NSAttributedString(string: desc, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 11), NSAttributedStringKey.foregroundColor: UIColor.darkGray]))
        }
        
        return attributedText
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 1 {
            
//            let dummySize = CGSize(width: view.frame.width - 8 - 8, height: 1000)
//            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
//            let rect = descriptionAttributedText().boundingRect(with: dummySize, options: options, context: nil)
            
            return CGSize(width: view.frame.width, height: 30)
        }
       if indexPath.item == 2 {
            let dummySize = CGSize(width: view.frame.width - 8 - 8, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rect = descriptionAttributedText().boundingRect(with: dummySize, options: options, context: nil)
            
            return CGSize(width: view.frame.width, height: rect.height + 30)
        }
        if indexPath.item == 3 {
        
            
            return CGSize(width: view.frame.width, height: 200)

        }
        return CGSize(width: view.frame.width, height: 200)
    }
    
   
    
}


class TitleCell: BaseCell {
    var listing: Listing? {
        didSet {
            
            if let theAddress = listing?.address?.full?.capitalized {
                
                nameLabel.text = theAddress
            }
            
            if let listPrice = listing?.listPrice{
                let nf = NumberFormatter()
                nf.numberStyle = .decimal
                let subTitleCost = "$\(nf.string(from: NSNumber(value:(UInt64(listPrice))))!)"
                costLabel.text = subTitleCost
            }
        }
    }
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    let costLabel: UILabel = {
        let label = UILabel()
        label.text = "400"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center

        return label
    }()
    let viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    override func setupViews() {
    
        addSubview(viewContainer)
        addSubview(nameLabel)
        addSubview(costLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: viewContainer)
        addConstraintsWithFormat("V:|[v0(40)]|", views: viewContainer)
        
        addConstraintsWithFormat("H:|[v0]|", views: nameLabel)
        addConstraintsWithFormat("V:|[v0]-8-|", views: nameLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: costLabel)
        addConstraintsWithFormat("V:|-22-[v0]", views: costLabel)

    }
}
class AppDetailDescriptionCell: BaseCell {
    

    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE DESCRIPTION"
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(textView)
        addSubview(dividerLineView)
        
//        addConstraintsWithFormat("H:[v0]", views: nameLabel)
//        addConstraintsWithFormat("V:|-8-[v0]", views: nameLabel)
        
        addConstraintsWithFormat("H:|-8-[v0]-8-|", views: textView)
        addConstraintsWithFormat("H:|-14-[v0]-14-|", views: dividerLineView)
        
        addConstraintsWithFormat("V:|-4-[v0]-4-[v1(1)]|", views: textView, dividerLineView)
    }
}



class MapCell: BaseCell, MKMapViewDelegate  {

    var mapView = MKMapView()

    var listing: Listing? {
        didSet {
            if let lat = listing?.geo?.lat, let lng = listing?.geo?.lng {
                
                let location = CLLocationCoordinate2DMake(lat, lng)
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, 27500.0, 27500.0)
                mapView.setRegion(coordinateRegion, animated: false)
                
                let pin = MKPointAnnotation()
                
                pin.coordinate = location
                mapView.addAnnotation(pin)
                
            }
        }
    }

    override func setupViews() {

        addSubview(mapView)
        addConstraintsWithFormat("H:|[v0]|", views: mapView)
        addConstraintsWithFormat("V:|[v0]|", views: mapView)
    }
}













extension UIView {
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
