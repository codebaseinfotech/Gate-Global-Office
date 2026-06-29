//
//  CreatePathVM.swift
//  Pathrium
//
//  Created by Kenil on 29/06/26.
//

import Foundation

class CreatePathVM {
    
    var successPathList: (() -> Void)?
    var failurePathList: ((String) -> Void)?
    
    var successPathDetails: (() -> Void)?
    var failurePathDetails: ((String) -> Void)?
    
    var successCreateTrack: (() -> Void)?
    var failureCreateTrack: ((String) -> Void)?
    
    var successCreatePath: (() -> Void)?
    var failureCreatePath: ((String) -> Void)?
    
    var successCreateDestinations: (() -> Void)?
    var failureCreateDestinations: ((String) -> Void)?
    
    var successDeleteMember: (() -> Void)?
    var failureDeleteMember: ((String) -> Void)?
    
    var pathList: [PathModel] = []
    var pathDetails: PathDetails?
    var trackDetails: TrackData?
    
    var pathId: Int = 0
    var track_id: Int = 0
    
    func getPathList() {
        APIClient.sharedInstance.showIndicaor()
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
                APIClient.sharedInstance.hideIndicator()
                self.failurePathList?(error)
                return
            }
            
            guard let response = response else {
                APIClient.sharedInstance.hideIndicator()
                self.failurePathList?("No response")
                return
            }
            
            if response.success {
                APIClient.sharedInstance.hideIndicator()
                self.pathList = response.data
                self.successPathList?()
            } else {
                APIClient.sharedInstance.hideIndicator()
                self.failurePathList?(response.message)
            }
        }
    }
    
    func getPathDetails() {
        APIClient.sharedInstance.showIndicaor()
        APIClient.sharedInstance.request(
            method: .get,
            url: .paths,
            parameters: [:],
            pathComponent: "/\(pathId)",
            needUserToken: true,
            responseType: PathDetailsResponse.self,
            parameterEncoding: .url
        ) { [weak self] response, error, statusCode in
            
            guard let self = self else { return }
            
            if let error = error {
                APIClient.sharedInstance.hideIndicator()
                self.failurePathDetails?(error)
                return
            }
            
            guard let response = response else {
                APIClient.sharedInstance.hideIndicator()
                self.failurePathDetails?("No response")
                return
            }
            
            if response.success == true {
                APIClient.sharedInstance.hideIndicator()
                self.pathDetails = response.data
                
                self.successPathDetails?()
            } else {
                APIClient.sharedInstance.hideIndicator()
                self.failurePathDetails?(response.message ?? "")
            }
        }
    }
    
    func createTrackName(name: String) {
        APIClient.sharedInstance.showIndicaor()
        
        let parameters: [String: Any] = [
            "path_id": pathId,
            "name": name
        ]
        
        APIClient.sharedInstance.request(
            method: .post,
            url: .createTrack,
            parameters: parameters,
            needUserToken: true,
            responseType: CreateTrackResponse.self,
            parameterEncoding: .json
        ) { [weak self] response, error, statusCode in
            
            guard let self = self else { return }
            
            if let error = error {
                APIClient.sharedInstance.hideIndicator()
                self.failureCreateTrack?(error)
                return
            }
            
            guard let response = response else {
                APIClient.sharedInstance.hideIndicator()
                self.failureCreateTrack?("No response")
                return
            }
            
            if response.success == true {
                APIClient.sharedInstance.hideIndicator()
                self.trackDetails = response.data
                self.successCreateTrack?()
            } else {
                APIClient.sharedInstance.hideIndicator()
                self.failureCreateTrack?(response.message ?? "")
            }
        }
    }
    
    func createPathName(name: String) {
        APIClient.sharedInstance.showIndicaor()
        
        let parameters: [String: Any] = [
            "name": name
        ]
        
        APIClient.sharedInstance.request(
            method: .post,
            url: .paths,
            parameters: parameters,
            needUserToken: true,
            responseType: PathDetailsResponse.self,
            parameterEncoding: .json
        ) { [weak self] response, error, statusCode in
            
            guard let self = self else { return }
            
            if let error = error {
                APIClient.sharedInstance.hideIndicator()
                self.failureCreatePath?(error)
                return
            }
            
            guard let response = response else {
                APIClient.sharedInstance.hideIndicator()
                self.failureCreatePath?("No response")
                return
            }
            
            if response.success == true {
                APIClient.sharedInstance.hideIndicator()
                
                self.pathId = response.data?.id ?? 0
                self.successCreatePath?()
            } else {
                APIClient.sharedInstance.hideIndicator()
                self.failureCreatePath?(response.message ?? "")
            }
        }
    }
    
    func createDestinations(name: String) {
        APIClient.sharedInstance.showIndicaor()
        
        let parameters: [String: Any] = [
            "track_id": self.track_id,
            "name": name
        ]
        
        APIClient.sharedInstance.request(
            method: .post,
            url: .createDestinations,
            parameters: parameters,
            needUserToken: true,
            responseType: CreateTrackResponse.self,
            parameterEncoding: .json
        ) { [weak self] response, error, statusCode in
            
            guard let self = self else { return }
            
            if let error = error {
                APIClient.sharedInstance.hideIndicator()
                self.failureCreateDestinations?(error)
                return
            }
            
            guard let response = response else {
                APIClient.sharedInstance.hideIndicator()
                self.failureCreateDestinations?("No response")
                return
            }
            
            if response.success == true {
                APIClient.sharedInstance.hideIndicator()
                
                self.pathId = response.data?.pathId ?? 0
                self.successCreateDestinations?()
            } else {
                APIClient.sharedInstance.hideIndicator()
                self.failureCreateDestinations?(response.message ?? "")
            }
        }
    }
    
    func removeMember(userIds: Int, pathId: Int) {
        
        APIClient.sharedInstance.showIndicaor()
        
        let params: [String: Any] = [
            "shareable_type": "path",
            "shareable_id": pathId,
            "user_id": userIds
        ]
        
        APIClient.sharedInstance.request(
            method: .delete,
            url: .removeMemeberToPath,
            parameters: params,
            needUserToken: true,
            responseType: RemoveMemberResponse.self,
            parameterEncoding: .json
        ) { [weak self] response, error, statusCode in
            
            guard let self = self else { return }
            
            APIClient.sharedInstance.hideIndicator()
            
            if let error = error {
                self.failureDeleteMember?(error)
                return
            }
            
            guard let response = response else {
                self.failureDeleteMember?("No response")
                return
            }
            
            if response.success == true {
                self.successDeleteMember?()
            } else {
                self.failureDeleteMember?(response.message ?? "")
            }
        }
    }
    
}
