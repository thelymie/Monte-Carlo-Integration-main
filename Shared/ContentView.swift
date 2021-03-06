//
//  ContentView.swift
//  Shared
//
//  Created by Jeff Terry on 12/31/20.
//  Modified by Will Limestall 26 Feb 2021

import SwiftUI

struct ContentView: View {
    
    @State var pi = 0.0
    @State var totalGuesses = 0.0
    @State var totalIntegral = 0.0
    @State var radius = 1.0
    @State var guessString = "23458"
    @State var totalGuessString = "0"
    @State var piString = "0.0"
    
    // State functions for Picker
    // Create a menu of selectable items
    // Type of plot menu slection
    var functionSelect = ["f(x) = x","f(x) = x^(2)","f(x) = e^(x)", "f(x) = e^(-x)","f(x) = x^(2) e^(x)", "f(x) = x^(2)e^(-x)"]
    // create state variable
    @State private var selectedFunctionIndex = 0
    
    // Create a menu of selectable items
    // Number of intertations
    var iterationSelect = ["10^3","10^4","10^5","10^6"]
    @State private var selectedIterationIndex = 0
    
    
    
    
    
    
    // Setup the GUI to monitor the data from the Monte Carlo Integral Calculator
    @ObservedObject var monteCarlo = MonteCarloCircle(withData: true)
    
    //Setup the GUI View
    var body: some View {
        HStack{
            
            VStack{
                
                // Drop Down menu for Function select
                VStack {
                    Text("Select Function")
                    // Picker is used to select a function it is placed into the slected function index.
                    Picker(selection: $selectedFunctionIndex, label: Text("")) {
                            ForEach(0 ..< functionSelect.count) {
                               Text(self.functionSelect[$0])
                            }
                    }.padding()
                    Text("Selected Function:  \(functionSelect[selectedFunctionIndex])")

                    
                }.padding()
                // Drop Down menu for Number of iterations
                VStack {
                    Text("Select Number of Iterations")
                    // Picker is used to select a function it is placed into the slected function index.
                    Picker(selection: $selectedIterationIndex, label: Text("")) {
                            ForEach(0 ..< iterationSelect.count) {
                               Text(self.iterationSelect[$0])
                            }
                    }.padding()
                    Text("Selected Function:  \(iterationSelect[selectedIterationIndex])")

                    
                }.padding()
                // Vstack for a manual entry for guesses
                VStack(alignment: .center) {
                    Text("Guesses")
                        .font(.callout)
                        .bold()
                    TextField("# Guesses", text: $guessString)
                        .padding()
                }
                .padding(.top, 5.0)
                
                VStack(alignment: .center) {
                    Text("Total Guesses")
                        .font(.callout)
                        .bold()
                    TextField("# Total Guesses", text: $totalGuessString)
                        .padding()
                }
                
                VStack(alignment: .center) {
                    Text("π")
                        .font(.callout)
                        .bold()
                    TextField("# π", text: $piString)
                        .padding()
                }
                
                Button("Cycle Calculation", action: {self.calculatePi()})
                    .padding()
                
                Button("Clear", action: {self.clear()})
                    .padding(.bottom, 5.0)
                
                
            }
            .padding()
            
            //DrawingField
            
            
            drawingView(redLayer:$monteCarlo.insideData, blueLayer: $monteCarlo.outsideData)
                .padding()
                .aspectRatio(1, contentMode: .fit)
                .drawingGroup()
            // Stop the window shrinking to zero.
            Spacer()
            
        }
    }
    
    func calculateIntegral(){
        
        
        
        
    }
    
    
    
    func calculatePi(){
        
        monteCarlo.guesses = Int(guessString)!
        monteCarlo.radius = radius
        monteCarlo.totalGuesses = Int(totalGuessString) ?? Int(0.0)
        
        monteCarlo.calculatePI()
        
        totalGuessString = monteCarlo.totalGuessesString
        
        piString =  monteCarlo.piString
        
        
        
    }
    
    func clear(){
        
        guessString = "23458"
        totalGuessString = "0.0"
        piString =  ""
        monteCarlo.totalGuesses = 0
        monteCarlo.totalIntegral = 0.0
        monteCarlo.insideData = []
        monteCarlo.outsideData = []
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
