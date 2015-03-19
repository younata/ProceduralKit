//
//  AppDelegate.swift
//  ProceduralKitExample
//
//  Created by Rachel Brindle on 3/17/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import Cocoa
import ProceduralKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var view: NSView!
    @IBOutlet weak var frequencyField: NSTextField!
    @IBOutlet weak var lacunarityField: NSTextField!
    @IBOutlet weak var octavesField: NSTextField!
    @IBOutlet weak var gainField: NSTextField!

    let layer = ProceduralKit.ProceduralLayer()
    let r = ProceduralKit.PerlinNoise(grid: ProceduralKit.PerlinNoise.generateGrid(100, width: 100))
    let g = ProceduralKit.PerlinNoise(grid: ProceduralKit.PerlinNoise.generateGrid(100, width: 100))
    let b = ProceduralKit.PerlinNoise(grid: ProceduralKit.PerlinNoise.generateGrid(100, width: 100))

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        view.wantsLayer = true
        layer.maxWidth = 10
        layer.maxHeight = 10
        layer.setColorsFromPerlinNoise(r.at, g: g.at, b: b.at)
        view.layer = layer
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    @IBAction func resetContent(sender: NSButton) {
//        let lacString = lacunarityField.stringValue as NSString
//        let lacunarity = CGFloat(lacString.doubleValue != 0 ? lacString.doubleValue : 2.0)
//
//        let octaves = octavesField.stringValue.toInt() ?? 6
//
//        let gainString = gainField.stringValue as NSString
//        let gain = CGFloat(gainString.doubleValue != 0 ? gainString.doubleValue : 0.65)
//
//        for fbm in [layer.red, layer.green, layer.blue] {
//            fbm.lacunarity = lacunarity
//            fbm.octaves = octaves
//            fbm.gain = gain
//        }
        layer.setNeedsDisplay()
        layer.setNeedsLayout()
    }
}

