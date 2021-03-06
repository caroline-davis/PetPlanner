//
//  Convenience.swift
//  PetPlanner
//
//  Created by Caroline Davis on 19/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alerts(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)    
    }
}

func saveBtnEnabled(save: UIButton, activityIndicator: UIActivityIndicatorView) {
    save.isUserInteractionEnabled = true
    activityIndicator.isHidden = true
    activityIndicator.stopAnimating()
    save.titleLabel?.isHidden = false
}

func saveBtnDisabled(save: UIButton, activityIndicator: UIActivityIndicatorView) {
    save.isUserInteractionEnabled = false
    save.titleLabel?.isHidden = true
    activityIndicator.isHidden = false
    activityIndicator.startAnimating()
}

extension UIImage {
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFill
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFill
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}

// export the petview
extension UIView {
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

// Convert String to Date
func convertToDate(originalString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    
    let convertedDate: Date = dateFormatter.date(from: originalString)!
    return convertedDate
}

/// Convert Date to String
func convertToString(originalDate: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    
    let convertedString: String = dateFormatter.string(from: originalDate) // pass Date here
    
    return convertedString
}

