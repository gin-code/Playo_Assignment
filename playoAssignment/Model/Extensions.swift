//
//  Extensions.swift
//  playoAssignment
//
//  Created by Sparsh Singh on 04/07/22.
//

import UIKit
import MBProgressHUD

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
