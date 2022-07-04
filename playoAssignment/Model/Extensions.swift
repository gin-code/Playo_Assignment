//
//  Extensions.swift
//  playoAssignment
//
//  Created by Sparsh Singh on 04/07/22.
//

import UIKit
import MBProgressHUD

class Extensions {
    
    static func displayAlert(title: String, message: String) {
     let alertController = UIAlertController(title: title  , message: message, preferredStyle: .alert)
     let defaultAction = UIAlertAction(title: "OK" , style: .default, handler: nil)
        alertController.addAction(defaultAction)
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
            fatalError("keyWindow has no rootViewController")
        }
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func downloadImageFromURl(UrlString: String, image: UIImageView) {
           
           if let url = URL(string: UrlString) {
               let task = URLSession.shared.dataTask(with: url) { data, response, error in
                   guard let data = data, error == nil else { return }
                   
                   DispatchQueue.main.async {
                       image.image = UIImage(data: data)
                   }
               }
               
               task.resume()
           }
           
       }
    
}

extension UIViewController {
    
    func showHUD(){
         DispatchQueue.main.async{
            let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            progressHUD.label.text = "Loading..."
         }
     }

     func dismissHUD() {
         DispatchQueue.main.async{
             MBProgressHUD.hide(for: self.view, animated: true)
         }
     }
    
   
    
}
