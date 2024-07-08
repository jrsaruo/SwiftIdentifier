//
//  IdentifierTests.swift
//  
//
//  Created by Yusaku Nishi on 2021/12/23.
//

import XCTest
import SwiftIdentifier

final class IdentifierTests: XCTestCase {
    
    private struct Sample: Codable, Equatable {
        typealias ID = Identifier<Self, Int>
        let id: ID
    }
    
    // MARK: - Literal expression tests
    
    func testExpressibleByIntegerLiteral() {
        let sampleID: Sample.ID = 10
        XCTAssertEqual(sampleID, Sample.ID(rawValue: 10))
    }
    
    func testExpressibleByStringLiteral() {
        typealias StringID = Identifier<Sample, String>
        
        let sampleID: StringID = "sample_id"
        XCTAssertEqual(sampleID, StringID(rawValue: "sample_id"))
        
        let text = "interpolated"
        let interpolatedID: StringID = "some_\(text)_id"
        XCTAssertEqual(interpolatedID, StringID(rawValue: "some_interpolated_id"))
    }
    
    // MARK: - Protocol conformance tests
    
    func testCustomStringConvertible() {
        let sampleID: Sample.ID = 10
        XCTAssertEqual("\(sampleID)", "10")
    }
    
    func testComparable() {
        let sampleID: Sample.ID = 10
        XCTAssertLessThan(sampleID, 100)
        XCTAssertGreaterThan(sampleID, 1)
    }
    
    @MainActor
    func testCodable() throws {
        let sampleJSONData = Data(#"{"id":10}"#.utf8) // NOTE: not {"id":{"rawValue":10}}
        
        try XCTContext.runActivity(named: "Identifier can be decoded from flat JSON") { _ in
            let decoder = JSONDecoder()
            let decodedSample = try decoder.decode(Sample.self, from: sampleJSONData)
            XCTAssertEqual(decodedSample, Sample(id: 10))
        }
        try XCTContext.runActivity(named: "Identifier can be encoded to flat JSON") { _ in
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(Sample(id: 10))
            XCTAssertEqual(encodedData, sampleJSONData)
        }
    }
}
