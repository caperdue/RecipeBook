//
//  Ingredient.swift
//  RecipeBook
//
//  Created by Carly Perdue on 9/13/20.
//  Copyright © 2020 Carly Perdue. All rights reserved.
//

import Foundation

enum IllegalEntryError: Error {
    case invalidName
    case illegalAmount
}
struct Ingredient {
    private var name:String
    private var amount:String
    private var measurementType:String
    
    static let availableSolidMeasurements:[String] = ["cups", "tbsp", "tsp", "lb", "pinch", "dash", "oz"]
    
    static let availableLiquidMeasurements:[String] = ["gal", "quart", "pint", "cups", "fl oz", "mL", "liter"]
    
    init(name: String, amount: String, measurementType: String) throws {
        self.name = name
        self.amount = amount
        self.measurementType = measurementType
        
        if name == "" {
            throw IllegalEntryError.invalidName
        }
        if amount == "" {
            throw IllegalEntryError.illegalAmount
        }
        
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getAmount() -> String {
        return self.amount
    }
    
    func getMeasurementType() -> String {
        return self.measurementType
    }
}

