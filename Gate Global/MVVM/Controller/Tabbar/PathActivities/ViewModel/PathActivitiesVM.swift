//
//  PathActivitiesVM.swift
//  Gate Global
//
//  Created by Poojagabani on 04/05/26.
//

import Foundation

class PathActivitiesVM {
    
    var paths: [PathModel] = []
    
    var onSuccess: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchPaths() {
        
        APIClient.sharedInstance.request(
            method: .get,
            url: .paths,
            parameters: [:],
            needUserToken: true,
            responseType: PathsResponseModel.self,
            parameterEncoding: .url
        ) { [weak self] response, error, statusCode in
            
            guard let self = self else { return }
            
            if let error = error {
                self.onError?(error)
                return
            }
            
            guard let response = response else {
                self.onError?("No response")
                return
            }
            
            if response.success {
                self.paths = response.data
                self.onSuccess?()
            } else {
                self.onError?(response.message)
            }
        }
    }
}
