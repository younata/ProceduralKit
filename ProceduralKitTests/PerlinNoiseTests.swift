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

    var grid : [[(x: CGFloat, y: CGFloat)]] = [
        [(x: 1, y: 0), (x: 0, y: 1)],
        [(x: 1, y: 0), (x: 0, y: 1)],
        [(x: 1, y: 0), (x: 0, y: 1)]
    ]

    override func setUp() {
        super.setUp()

        subject = PerlinNoise(grid: grid)
    }

    func testLinearInterpolation() {
        XCTAssertEqual(subject.linearInterpolation(1, 2, weight: 0.5), 1.5, "Linear Interpolation between two values")
        XCTAssertEqualWithAccuracy(subject.linearInterpolation(1, 2, weight: 0.2), 1.2, 1e-6, "Linear Interpolation between two values")
    }

    func testDotProductGradient() {
        XCTAssertEqualWithAccuracy(subject.dotProductGradient(1, iy: 1, x: 1.2, y: 1.2), 0.2, 1e-6, "")
    }

    func testPerformance() {
        let g = PerlinNoise.generateGrid(100, width: 100)
        subject = PerlinNoise(grid: g)
        self.measureBlock() {
            for i in 0..<1000 {
                var x = (CGFloat(arc4random_uniform(500000)) / 500000.0) * 99
                var y = (CGFloat(arc4random_uniform(500000)) / 500000.0) * 99
                self.subject.at(x, y)
            }
        }
    }

}
