//
//  PerlinNoiseTests.swift
//  ProceduralKit
//
//  Created by Rachel Brindle on 3/11/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import Foundation
import XCTest

class PerlinNoiseTests: XCTestCase {

    var subject : PerlinNoise! = nil

    override func setUp() {
        super.setUp()

        let noise : (Double, Double) -> (Double) = {(x, y) in x*y}
        subject = PerlinNoise(noise: noise)
    }

    func testLinearInterpolation() {
        XCTAssertEqual(subject.linearInterpolation(1, 2, weight: 0.5), 1.5, "Linear Interpolation between two values")
        XCTAssertEqualWithAccuracy(subject.linearInterpolation(1, 2, weight: 0.2), 1.2, 1e-6, "Linear Interpolation between two values")
    }

    func testCosineInterpolation() {
        XCTAssertEqual(subject.cosineInterpolation(1, 2, weight: 0.5), 1.5, "Cosine Interpolation between two values")
        XCTAssertEqualWithAccuracy(subject.cosineInterpolation(1, 2, weight: 0.2), 1.095491, 1e-6, "Cosine Interpolation between two values")
    }

    func testDotProductGradient() {
        XCTAssertEqualWithAccuracy(subject.dotProductGradient(1, iy: 1, x: 1.2, y: 1.2), 0.2, 1e-6, "")

        XCTAssertEqualWithAccuracy(subject.dotProductGradient(0, iy: 0, x: 0.4, y: 0.6), 0, 1e-6, "")
        XCTAssertEqualWithAccuracy(subject.dotProductGradient(0, iy: 0, x: 0.8, y: 0.8), 0, 1e-6, "")
    }

    func testAt() {
        XCTAssertEqualWithAccuracy(subject.at(2,1), 0, 1e-6, "")
        XCTAssertEqualWithAccuracy(subject.at(-1,-2), 0, 1e-6, "Below the bounds")
        XCTAssertEqualWithAccuracy(subject.at(4,2), 0, 1e-6, "Beyond the bounds")
    }

    func testPerformance() {
        subject = PerlinNoise() {(x, y) in noise(x, y: y)}
        self.measureBlock() {
            for i in 0..<1000 {
                var x = (Double(arc4random_uniform(500000)) / 500000.0) * 100
                var y = (Double(arc4random_uniform(500000)) / 500000.0) * 100
                self.subject.at(x, y)
            }
        }
    }

}
