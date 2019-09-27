//
//  NewsFeedViewController.swift
//  GoSpark
//
//  Created by sarwesh reddy on 27/09/19.
//  Copyright © 2019 sarwesh reddy. All rights reserved.
//

import UIKit
import WebKit
class NewsFeedViewController: UIViewController {

    //MARK:- variables
    let webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeWebView()
        addLogOutButton()
    }

    //MARK:- view and button intialiazation
    func intializeWebView() {
        webView.frame = self.view.frame
        if let request = prepareKstreamRequest() {
            webView.load(request)
        }
        self.view.addSubview(webView)
    }
    func addLogOutButton() {
        let button = UIBarButtonItem(title: "logout", style: .done, target: self, action: #selector(logoutClicked))
        self.navigationItem.rightBarButtonItem = button
    }
    //MARK:- button action
    @objc func logoutClicked() {
        UserDefaults.standard.removeObject(forKey: "token")
        changeRootViewController()
    }
    //MARK:- custom methods
    func prepareKstreamRequest() -> URLRequest? {
        guard let url = AppUrls.kstreamUrl else {return nil}
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {return nil}
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    func changeRootViewController() {
         var vc: UIViewController?
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
            vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
         let nav = UINavigationController(rootViewController: vc!)
         UIApplication.shared.keyWindow?.rootViewController = nav
     }
}
