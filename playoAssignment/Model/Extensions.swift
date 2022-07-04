//
//  Extensions.swift
//  playoAssignment
//
//  Created by Sparsh Singh on 04/07/22.
//

import UIKit
import MBProgressHUD

class Extensions {
    
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
            progressHUD.hide(animated: true, afterDelay: 5)
         }
     }

     func dismissHUD() {
         DispatchQueue.main.async{
             MBProgressHUD.hide(for: self.view, animated: true)
         }
     }
    
   
    
}
