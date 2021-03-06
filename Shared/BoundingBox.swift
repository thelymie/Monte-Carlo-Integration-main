//
//  BoundingBox.swift
//  Monte Carlo Integration
//
//  Created by Jeff Terry on 12/31/20.
//  Modified by Will Limestall 26 Feb. 2021

import Foundation
import SwiftUI

class BoundingBox: NSObject {
    
    //  calculateVolume function
    // Parameters:
    // lengthOfSide1: length of the first side
    // lengthOfSide2: length of the second side
    // lengthOfSide3: length of the third side
    // Returns: returns the volume of a box
    func calculateVolume(lengthOfSide1: Double, lengthOfSide2: Double, lengthOfSide3: Double) -> Double {
        //create constant for Volume
        let Volume = lengthOfSide1*lengthOfSide2*lengthOfSide3
        return (Volume)
        
    }
    
    // Calculate the surface area of square & box funciton
    // Parameters:
    // numberOfSides: number of sides of the box
    // lengthOfSide1: length of the first side
    // lengthOfSide2: length of the second side
    //  engthOfSide3: length of the third side
    // Returns: returns the surface area of the box
    func calculateSurfaceArea(numberOfSides: Int, lengthOfSide1: Double, lengthOfSide2: Double, lengthOfSide3: Double) -> Double {
        // need variable for Surface area
        var surfaceArea = 0.0
        // If statement for Surface Area of a square
        switch numberOfSides {
        case 2:
            surfaceArea = lengthOfSide1*lengthOfSide2
        case 6:
            surfaceArea = 2*lengthOfSide1*lengthOfSide2 + 2*lengthOfSide2*lengthOfSide3 + 2*lengthOfSide1*lengthOfSide3
        default:
            surfaceArea = 0.0
        }
        // return surface area
        return (surfaceArea)
        }
        
       
    

}

