//
//  LoginViewModel.swift
//  GoSpark
//
//  Created by sarwesh reddy on 27/09/19.
//  Copyright © 2019 sarwesh reddy. All rights reserved.
//

import Foundation
protocol ResponseDelegate {
    func responseReceived()
}
class LoginViewModel {
    var loginResponse: LogInResponse?
    var delegate: ResponseDelegate?
    func prepareLoginRequest(_ email: String,_ password: String) -> URLRequest? {
        guard let url = AppUrls.loginUrl else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
        let data = try LogInRequest(email: email, password: password).jsonData()
        request.httpBody = data
        } catch {
            print("error")
        }
        return request
    }
    func performLoginRequest(_ email: String,_ password: String,closure : @escaping(Data) -> Void) {
        guard let request = prepareLoginRequest(email,password) else {return}
        let defaultSession = URLSession(configuration: .default)
        let dataTask = defaultSession.dataTask(with: request) {  data, response, error in
                      if let error = error {
                        print(error)
                      } else if let data = data{
                        closure(data)
                      }
                    }
                    dataTask.resume()
    }
    func performLogin(email: String,password: String) {
        performLoginRequest(email,password){ data in
                 do {
                    self.loginResponse = try LogInResponse(data: data)
                    self.delegate?.responseReceived()
                 } catch {
                     print("error")
                 }
             }
    }
    
}
