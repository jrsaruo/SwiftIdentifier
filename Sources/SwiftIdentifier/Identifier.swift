//
//  Identifier.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/22.
//

/// A structure to provide a different ID type for each type.
///
/// ```
/// struct User {
///     typealias ID = Identifier<Self, Int>
///     let id: ID
/// }
/// struct Book {
///     typealias ID = Identifier<Self, Int>
///     let id: ID
/// }
/// let user = User(id: 10) // OK
/// let book = Book(id: 10) // OK
///
/// func fetchProfile(with id: User.ID) -> Profile { ... }
/// fetchProfile(with: user.id) // OK
/// fetchProfile(with: book.id) // Compile error
/// ```
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

// MARK: - ExpressibleByIntegerLiteral

extension Identifier: ExpressibleByIntegerLiteral where RawValue: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: RawValue.IntegerLiteralType) {
        self.init(rawValue: RawValue(integerLiteral: value))
    }
}

// MARK: - ExpressibleByStringLiteral

extension Identifier: ExpressibleByUnicodeScalarLiteral where RawValue: ExpressibleByUnicodeScalarLiteral {
    
    public init(unicodeScalarLiteral value: RawValue.UnicodeScalarLiteralType) {
        self.init(rawValue: RawValue(unicodeScalarLiteral: value))
    }
}

extension Identifier: ExpressibleByExtendedGraphemeClusterLiteral where RawValue: ExpressibleByExtendedGraphemeClusterLiteral {
    
    public init(extendedGraphemeClusterLiteral value: RawValue.ExtendedGraphemeClusterLiteralType) {
        self.init(rawValue: RawValue(extendedGraphemeClusterLiteral: value))
    }
}

extension Identifier: ExpressibleByStringLiteral where RawValue: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: RawValue.StringLiteralType) {
        self.init(rawValue: RawValue(stringLiteral: value))
    }
}

// MARK: - ExpressibleByStringInterpolation

extension Identifier: ExpressibleByStringInterpolation where RawValue: ExpressibleByStringInterpolation {
    
    public init(stringInterpolation: RawValue.StringInterpolation) {
        self.init(rawValue: .init(stringInterpolation: stringInterpolation))
    }
}
