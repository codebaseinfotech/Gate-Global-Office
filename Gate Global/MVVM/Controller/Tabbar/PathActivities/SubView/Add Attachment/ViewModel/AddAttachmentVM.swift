//
//  AddAttachmentVM.swift
//  Pathrium
//
//  Created by Kenil on 29/06/26.
//

import Foundation

class AddAttachmentVM {
    
    var successGenreal: (() -> Void)?
    var failureGenreal: ((String) -> Void)?
    
    var successLookUps: (() -> Void)?
    var failureLookUps: ((String) -> Void)?
    
    var valueList: [LookupItem] = []
    var companyList: [LookupItem] = []
    var entityList: [LookupItem] = []
    
    var colorList: [MasterColorTag] = []
    var statusList: [MasterStatus] = []
    
    func getGeneralList() {
        APIClient.sharedInstance.showIndicaor()
        APIClient.sharedInstance.request(
            method: .get,
            url: .getGeneral,
            parameters: [:],
            needUserToken: false,
            responseType: MasterDataResponse.self,
            parameterEncoding: .url
        ) { [weak self] response, error, statusCode in
            
            guard let self = self else { return }
            
            if let error = error {
                APIClient.sharedInstance.hideIndicator()
                self.failureGenreal?(error)
                return
            }
            
            guard let response = response else {
                APIClient.sharedInstance.hideIndicator()
                self.failureGenreal?("No response")
                return
            }
            
            if response.success == true {
                APIClient.sharedInstance.hideIndicator()
                self.colorList = response.data?.colorTags ?? []
                self.statusList = response.data?.statuses ?? []
                
                self.successGenreal?()
            } else {
                APIClient.sharedInstance.hideIndicator()
                self.failureGenreal?("No response")
            }
        }
    }
    
    func getLockUp() {
        APIClient.sharedInstance.showIndicaor()
        APIClient.sharedInstance.request(
            method: .get,
            url: .getLookups,
            parameters: [:],
            needUserToken: true,
            responseType: LookupsResponseModel.self,
            parameterEncoding: .url
        ) { [weak self] response, error, statusCode in
            
            guard let self = self else { return }
            
            if let error = error {
                APIClient.sharedInstance.hideIndicator()
                self.failureLookUps?(error)
                return
            }
            
            guard let response = response else {
                APIClient.sharedInstance.hideIndicator()
                self.failureLookUps?("No response")
                return
            }
            
            if response.success == true {
                APIClient.sharedInstance.hideIndicator()
                self.valueList = response.data?.attachmentTypes ?? []
                self.companyList = response.data?.companies ?? []
                self.entityList = response.data?.entities ?? []
                
                self.successLookUps?()
            } else {
                APIClient.sharedInstance.hideIndicator()
                self.failureLookUps?("No response")
            }
        }
    }
}
