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
    
    var valueList: [VaultType] = []
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
                self.valueList = response.data?.vaultTypes ?? []
                self.colorList = response.data?.colorTags ?? []
                self.statusList = response.data?.statuses ?? []
                
                self.successGenreal?()
            } else {
                APIClient.sharedInstance.hideIndicator()
                self.failureGenreal?("No response")
            }
        }
    }
}
