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

// MARK: - CustomStringConvertible -

extension Identifier: CustomStringConvertible {
    
    public var description: String {
        "\(rawValue)"
    }
}

// MARK: - Conditional protocol conformances -

extension Identifier: Equatable where RawValue: Equatable {}
extension Identifier: Hashable where RawValue: Hashable {}

// MARK: - Comparable

extension Identifier: Comparable where RawValue: Comparable {
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

// MARK: - Codable

extension Identifier: Decodable where RawValue: Decodable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        rawValue = try container.decode(RawValue.self)
    }
}

extension Identifier: Encodable where RawValue: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
