//
//  registerViewModel.swift
//  GoSpark
//
//  Created by sarwesh reddy on 27/09/19.
//  Copyright © 2019 sarwesh reddy. All rights reserved.
//

import Foundation

class RegisterViewModel {
    var registerResponse: RegisterResponse?
    var delegate: ResponseDelegate?
    func prepareRegisterRequest(_ registerRequest: RegisterRequest) -> URLRequest? {
        guard let url = AppUrls.registerUrl else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        do {
        let data = try registerRequest.jsonData()
        request.httpBody = data
        } catch {
            print("error")
        }
        return request
    }
    
    func performRegisterRequest(_ registerRequest: RegisterRequest,closure : @escaping(Data) -> Void) {
        guard let request = prepareRegisterRequest(registerRequest) else {return}
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
    func performRegister(_ registerRequest: RegisterRequest) {
        performRegisterRequest(registerRequest){ data in
                 do {
                    self.registerResponse = try RegisterResponse(data: data)
                    self.delegate?.responseReceived()
                 } catch {
                     print("error")
                 }
             }
    }
    
}
