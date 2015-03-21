//
//  FBMTests.swift
//  ProceduralKit
//
//  Created by Rachel Brindle on 3/11/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import XCTest

class FBMTests: XCTestCase {

    var subject : FractalBrownianMotion! = nil

    override func setUp() {
        super.setUp()

        subject = FractalBrownianMotion()
    }

    func testLacunarity() {
        XCTAssertEqualWithAccuracy(subject.at(0,0), 0.286179, 1e-6, "Lacunarity of 2")
        subject.lacunarity = 1
        XCTAssertEqualWithAccuracy(subject.at(0,0), 0.286179, 1e-6, "Lacunarity of 1")
        subject.lacunarity = 4
        XCTAssertEqualWithAccuracy(subject.at(0,0), 0.286179, 1e-6, "Lacunarity of 4")
    }

    func testOctaves() {
        XCTAssertEqualWithAccuracy(subject.at(0,0), 0.286179, 1e-6, "3 Octaves")

        subject.octaves = 1
        XCTAssertEqualWithAccuracy(subject.at(0,0), 0.65, 1e-6, "1 Octave")

        subject.octaves = 6
        XCTAssertEqualWithAccuracy(subject.at(0,0), 0.286179, 1e-6, "6 Octaves")
    }

    func testNoise() {
        XCTAssertEqualWithAccuracy(subject.at(0,0), 0.286179, 1e-6, "return 1")

        subject.noise = {(x, y) in (x*x)/(y*y)}
        XCTAssertEqualWithAccuracy(subject.at(2,3), 0.127191, 1e-6, "return x*y")

        let noise = PerlinNoise() {(x, y) in
            return x == 0 ? 1.0 : 0.0
        }
        subject.noise = noise.at

        XCTAssertEqualWithAccuracy(subject.at(1,1), 0.010598, 1e-6, "return noise")
    }

    func testPerformance() {
        let perlinNoise = PerlinNoise() {(x, y) in noise(x, y: y)}
        subject.noise = {(x, y) in perlinNoise.at(x, y)}
        subject.octaves = 10

        self.measureBlock() {
            for i in 0..<1000 {
                var x = (Double(arc4random_uniform(500000)) / 500000.0) * 99
                var y = (Double(arc4random_uniform(500000)) / 500000.0) * 99
                self.subject.at(x, y)
            }
        }
    }

}
