//
//  WebViewVC.swift
//  playoAssignment
//
//  Created by Sparsh Singh on 04/07/22.
//

import UIKit
import WebKit

class WebViewVC: UIViewController {
    
    var urlString : String = ""
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url : URL! = URL(string: urlString)
        webView.load(URLRequest(url: url))
    }
    

    @IBAction func backBtnAct(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
