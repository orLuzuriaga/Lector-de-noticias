//
//  DetalleViewController.swift
//  LectorDeNoticias
//
//  Created by Renato on 09/09/2019.
//  Copyright © 2019 RenatoLuzuriaga. All rights reserved.
//

import UIKit
import WebKit


class DetalleViewController: UIViewController, WKUIDelegate {

   
    private var webView: WKWebView!
    
    
    //MARK: - Private
    var detalleNoticia:Noticias?
 
 
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let link = detalleNoticia?.link{
            let myRequest = URLRequest(url: link)
            webView.load(myRequest)
            
            
        }else{
            
            let myURL = URL(string:"https://about.me/renatoLuzuriaga")
            let myRequest = URLRequest(url:myURL!)
            webView.load(myRequest)
        }
       
        /*let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        /*
        if let noticiaActual = detalleNoticia{
            let title:String
            
       
            webView.loadHTMLString(noticiaActual.content.rendered, baseURL: nil)
            
        }*/
 
 */
        let tap = UITapGestureRecognizer(target: self, action: #selector(tocoPantalla(sender:)))
        view.addGestureRecognizer(tap)
      
        
        
       
   
    }
  
    
    @objc func tocoPantalla(sender:UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    


    
    
    
   
    
    
    
}
