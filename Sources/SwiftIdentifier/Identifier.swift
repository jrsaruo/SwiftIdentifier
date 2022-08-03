//
//  Identifier.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/22.
//

/// A structure to provide a different ID type for each type.
public struct Identifier<Identified, RawValue>: RawRepresentable {
    
    public let rawValue: RawValue
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}
