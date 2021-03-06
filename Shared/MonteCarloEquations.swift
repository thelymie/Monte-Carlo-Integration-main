//
//  File.swift
//  Monte Carlo Integration
//
//  Created by William Limestall on 2/26/21.
//

import Foundation
import SwiftUI

class MonteCarloEquations: NSObject, ObservableObject {
    
    @Published var belowCurveData = [(xPoint: Double, yPoint: Double)]()
    @Published var aboveCurveData = [(xPoint: Double, yPoint: Double)]()
    @Published var totalGuessesString = ""
    @Published var guessesString = ""
    @Published var piString = ""
    
    @Published var selectionIndex = 0
    
    
    var pi = 0.0
    var guesses = 1
    var totalGuesses = 0
    var totalIntegral = 0.0
    var radius = 1.0
    
    init(withData data: Bool){
        
        super.init()
        
        belowCurveData = []
        aboveCurveData = []
        
    }


    /// calculate the value of π
    ///
    /// - Calculates the Value of π using Monte Carlo Integration
    ///
    /// - Parameter sender: Any
    func calculatePI() {
        
        var maxGuesses = 0.0
        let boundingBoxCalculator = BoundingBox() ///Instantiates Class needed to calculate the area of the bounding box.
        
        
        maxGuesses = Double(guesses)
        
        
        
        
        totalIntegral = totalIntegral + calculateMonteCarloIntegral(selector: selectionIndex, radius: radius, maxGuesses: maxGuesses)
        
        totalGuesses = totalGuesses + guesses
        
        totalGuessesString = "\(totalGuesses)"
        
        ///Calculates the value of π from the area of a unit circle
        
        pi = totalIntegral/Double(totalGuesses) * boundingBoxCalculator.calculateSurfaceArea(numberOfSides: 2, lengthOfSide1: 2.0*radius, lengthOfSide2: 2.0*radius, lengthOfSide3: 0.0)
        
        piString = "\(pi)"
        
       
        
    }

    //calculates the Monte Carlo Integral of a Circle
    //
    // Parameters:
    // radius: radius of circle
    // maxGuesses: number of guesses to use in the calculaton
    // Returns: ratio of points inside to total guesses. Must mulitply by area of box in calling function
    func calculateMonteCarloIntegral(selector: Int,radius: Double, maxGuesses: Double) -> Double {
        
        var numberOfGuesses = 0.0
        var PointsUnderCurve = 0.0
        var integral = 0.0
        var point = (xPoint: 0.0, yPoint: 0.0)
        var EvaluateIntegral = 0.0
        
        var newInsidePoints : [(xPoint: Double, yPoint: Double)] = []
        var newOutsidePoints : [(xPoint: Double, yPoint: Double)] = []
        
        
        while numberOfGuesses < maxGuesses {
            
            /* Calculate 2 random values within the box */
            /* Determine the distance from that point to the origin */
            /* If the distance is less than the unit radius count the point being within the Unit Circle */
            point.xPoint = Double.random(in: 0...1)
            point.yPoint = Double.random(in: 0...1)
            
            EvaluateIntegral = exp(-point.xPoint)
            
            
            //EvaluateIntegral = sqrt(pow(point.xPoint,2.0) + pow(point.yPoint,2.0))
            
            
            // if inside the circle add to the number of points in the radius
            if((point.yPoint - EvaluateIntegral) > 0.0){
                PointsUnderCurve += 1.0
                
                
                newInsidePoints.append(point)
               
            }
            else { //if outside the circle do not add to the number of points in the radius
                
                
                newOutsidePoints.append(point)

                
            }
            
            numberOfGuesses += 1.0
            
            
            
            
            }

        
        integral = Double(PointsUnderCurve)
        
        //Append the points to the arrays needed for the displays
        //Don't attempt to draw more than 250,000 points to keep the display updating speed reasonable.
        
        if ((totalGuesses < 1000001) || (belowCurveData.count == 0)){
        
            belowCurveData.append(contentsOf: newInsidePoints)
            aboveCurveData.append(contentsOf: newOutsidePoints)
            
        }
        
        return integral
        }

}
