//
//  CreateSessionViewController.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 19.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import UIKit
import WebKit

protocol CreateSessionPresentableListener: class {
    func getURL() -> URL
    func checkURL(url: URL)
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class CreateSessionViewController: UIViewController, WKNavigationDelegate, CreateSessionPresentable, CreateSessionViewControllable {
    
    weak var listener: CreateSessionPresentableListener?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        let url = listener?.getURL()
        webView.load(URLRequest(url: url!))
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        listener?.checkURL(url: webView.url!)
    }
}
