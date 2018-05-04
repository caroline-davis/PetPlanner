//
//  GalleryVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 4/4/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit
import SDWebImage

class GalleryVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    var collectionViewData = [PetImage]()

    
    @IBOutlet weak var collection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        
        DataService.ds.getPhotos(petId: CURRENT_PET_ID) { (petImage) in
            self.collectionViewData = petImage
            self.collection.reloadData()
            
        }
        
    }
        
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell {
            let pet = self.collectionViewData[indexPath.row]
            
            cell.configure(petImage: pet)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let pet = self.collectionViewData[indexPath.row]
         let photo = pet.photo
        // get the photoId and save it so we can open it in the next window
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewPhotoVC") as! ViewPhotoVC
        vc.petPhoto = photo
        self.navigationController?.pushViewController(vc, animated: false)

        
    }
    
    func delete(at indexthPath: [IndexPath]) {
        
    }
    
    

}
