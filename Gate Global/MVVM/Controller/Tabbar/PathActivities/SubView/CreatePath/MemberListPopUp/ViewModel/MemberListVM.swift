//
//  MemberListVM.swift
//  Pathrium
//
//  Created by Kenil on 29/06/26.
//

import Foundation

class MemberListVM {
    
    var successMemberList: (() -> Void)?
    var failureMemberList: ((String) -> Void)?
    
    var successAddMember: (() -> Void)?
    var failureAddMember: ((String) -> Void)?
    
    var membersList: [MemberUser] = []
    
    func getMemberList() {
        APIClient.sharedInstance.showIndicaor()
        APIClient.sharedInstance.request(
            method: .get,
            url: .getUser,
            parameters: [:],
            needUserToken: true,
            responseType: MemberResponse.self,
            parameterEncoding: .url
        ) { [weak self] response, error, statusCode in
            
            guard let self = self else { return }
            
            if let error = error {
                APIClient.sharedInstance.hideIndicator()
                self.failureMemberList?(error)
                return
            }
            
            guard let response = response else {
                APIClient.sharedInstance.hideIndicator()
                self.failureMemberList?("No response")
                return
            }
            
            if response.success == true {
                APIClient.sharedInstance.hideIndicator()
                self.membersList = response.data?.users ?? []
                
                self.successMemberList?()
            } else {
                APIClient.sharedInstance.hideIndicator()
                self.failureMemberList?(response.message ?? "")
            }
        }
    }
    
    func addMemberPath(userIds: [Int], pathId: Int) {
        
        APIClient.sharedInstance.showIndicaor()
        
        let params: [String: Any] = [
            "shareable_type": "path",
            "shareable_id": pathId,
            "user_ids": userIds
        ]
        
        APIClient.sharedInstance.request(
            method: .post,
            url: .addMemeberToPath,
            parameters: params,
            needUserToken: true,
            responseType: MembersSyncResponse.self,
            parameterEncoding: .json
        ) { [weak self] response, error, statusCode in
            
            guard let self = self else { return }
            
            APIClient.sharedInstance.hideIndicator()
            
            if let error = error {
                self.failureAddMember?(error)
                return
            }
            
            guard let response = response else {
                self.failureAddMember?("No response")
                return
            }
            
            if response.success == true {
                self.successAddMember?()
            } else {
                self.failureAddMember?(response.message)
            }
        }
    }
    
}
