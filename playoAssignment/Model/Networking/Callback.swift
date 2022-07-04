//
//  Callback.swift
//  getBasis
//
//  Created by Sparsh Singh on 13/06/22.
//

import Foundation

public class Callback<T, V> {
    
    private let successBlock: (T) -> Void
    private let failureBlock: (V) -> Void
    
    public init(onSuccess: @escaping (T) -> Void, onFailure: @escaping (V) -> Void) {
        self.successBlock = onSuccess
        self.failureBlock = onFailure
    }
    
    public func onSuccess(_ successResponse: T) {
        successBlock(successResponse)
    }
    
    public func onFailure(_ failureResponse: V) {
        failureBlock(failureResponse)
    }
    
}
