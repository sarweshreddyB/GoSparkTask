//
//  AppUrls.swift
//  GoSpark
//
//  Created by sarwesh reddy on 27/09/19.
//  Copyright © 2019 sarwesh reddy. All rights reserved.
//

import Foundation

struct AppUrls {
    static let baseUrl = "https://gospark.app/api/v1/"
    static let login = "login"
    static let register = "register"
    static let kstream = "kstream"
    static let loginUrl: URL? = {
        return URL(string: "\(baseUrl)\(login)")
    }()
    static let registerUrl: URL? = {
        return URL(string: "\(baseUrl)\(register)")
    }()
    static let kstreamUrl: URL? = {
        return URL(string: "\(baseUrl)\(kstream)")
    }()
}
