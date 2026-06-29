//
//  Constants.swift
//  Qadsia Club
//
//  Created by Kenil on 05/02/26.
//

import Foundation

enum AppEnviroment {
    case live
    case dev
}

let current: AppEnviroment = .dev


// ************************* LIVE ***********************
let BASE_URL = current == .live ? "https://ggodev.si-kw.com/api/" : "https://ggodev.si-kw.com/api/"

enum APIEndPoint: String {
    case login = "v1/auth/login"
    case sendOtp = "v1/auth/send-otp"
    case verifyOtp = "v1/auth/verify-otp"
    case logout = "v1/auth/logout"
    case paths = "v1/paths"
    case createTrack = "v1/tracks"
    case createDestinations = "v1/destinations"
    case getUser = "v1/users"
    case addMemeberToPath = "v1/member/add"
    case removeMemeberToPath = "v1/member/remove"
}
