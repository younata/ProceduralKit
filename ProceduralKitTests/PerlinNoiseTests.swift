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

    func testMaxWidth() {
        let grid = PerlinNoise.generateGrid(10, width: 20)
        subject = PerlinNoise(grid: grid)
        XCTAssertEqualWithAccuracy(subject.maxWidth, 20.0, 1e-12, "maxWidth")
    }

    func testMaxHeight() {
        let grid = PerlinNoise.generateGrid(10, width: 20)
        subject = PerlinNoise(grid: grid)
        XCTAssertEqualWithAccuracy(subject.maxHeight, 10.0, 1e-12, "maxHeight")
    }

    func testGenerateGrid() {
        let grid = PerlinNoise.generateGrid(80, width: 100)
        XCTAssertEqual(grid.count, 81, "Grid length")
        for g in grid {
            XCTAssertEqual(g.count, 101, "Grid width")
            for pair in g {
                XCTAssertEqualWithAccuracy(hypot(pair.x, pair.y), 1.0, 1e-6, "Must be vectors along unit circle")
            }
        }
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
    }

    func testAt() {
        XCTAssertEqualWithAccuracy(subject.at(2,1), 0, 1e-6, "")
        XCTAssertEqualWithAccuracy(subject.at(-1,-2), -2.0, 1e-6, "Below the bounds")
        XCTAssertEqualWithAccuracy(subject.at(4,2), 2, 1e-6, "Beyond the bounds")
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
