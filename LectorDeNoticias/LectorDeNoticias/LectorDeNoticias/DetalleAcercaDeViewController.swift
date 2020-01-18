//
//  DetalleAcercaDeViewController.swift
//  LectorDeNoticias
//
//  Created by Dev1 on 13/09/2019.
//  Copyright © 2019 RenatoLuzuriaga. All rights reserved.
//

import UIKit
import WebKit


class DetalleAcercaDeViewController: UIViewController, WKUIDelegate{

     private var webView: WKWebView!
    
    
    
   
    
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
            let myURL = URL(string:"https://about.me/renatoLuzuriaga")
            let myRequest = URLRequest(url:myURL!)
            webView.load(myRequest)
            
        /*let myURL = URL(string:"https://www.apple.com")
         let myRequest = URLRequest(url: myURL!)
         webView.load(myRequest)
         
         */
        let tap = UITapGestureRecognizer(target: self, action: #selector(tocoPantalla(sender:)))
        view.addGestureRecognizer(tap)
        
        
        
        
        
    }
    
    
    @objc func tocoPantalla(sender:UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    
    
    
    
    

}
