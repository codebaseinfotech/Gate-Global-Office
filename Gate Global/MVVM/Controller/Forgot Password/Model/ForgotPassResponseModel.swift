//
//  ForgotPassResponseModel.swift
//  Gate Global
//
//  Created by Poojagabani on 28/04/26.
//

import Foundation

struct ForgotPassResponseModel: Codable {
    let success: Bool
    let statusCode: Int
    let message: String
    let data: ForgotOTPData?
    let meta: Meta?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message
        case data
        case meta
    }
}

// MARK: - OTP Data
struct ForgotOTPData: Codable {
    let otpSentTo: String
    let otpType: String
    let expiresIn: Int
    let resendAvailableIn: Int

    enum CodingKeys: String, CodingKey {
        case otpSentTo = "otp_sent_to"
        case otpType = "otp_type"
        case expiresIn = "expires_in"
        case resendAvailableIn = "resend_available_in"
    }
}
