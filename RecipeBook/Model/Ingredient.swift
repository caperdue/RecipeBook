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
class Ingredient {
    private var name:String?
    private var amount:Dictionary<String, Int>?
    private var measurementType:String?
    private var liquidOrSolid:String?
    
    static let availableSolidMeasurements:[String] = ["cups", "tbsp", "tsp", "lb", "pinch", "dash", "oz"]
    static let availableLiquidMeasurements:[String] = ["gal", "quart", "pint", "cups", "fl oz", "mL", "liter"]
    
    init(name: String?, amount: Dictionary<String, Int>?, measurementType: String?, liquidOrSolid: String?) throws {
        //Error handling for invalid object
        if name == "" {
            throw IllegalEntryError.invalidName
        }
        if amount == nil {
            throw IllegalEntryError.illegalAmount
        }
        if liquidOrSolid != "liquid" && liquidOrSolid != "solid" {
            throw IllegalEntryError.illegalAmount
        }
        
        self.name = name
        self.amount = amount
        self.measurementType = measurementType
        self.liquidOrSolid = liquidOrSolid
        
    }
    
    init() {
        
    }
    func parseAmount() -> String {
        var stringAmount = ""
        let whole = amount!["whole"]!
        let numerator = amount!["numerator"]!
        let denominator = amount!["denominator"]!
        if whole > 0 {
            stringAmount = "\(stringAmount)\(whole)"
        }
        if numerator > 0 && denominator > 0 {
            stringAmount = "\(stringAmount) \(numerator)/\(denominator)"
        }
        stringAmount = "\(stringAmount) \(String(describing: measurementType!)) \(String(describing: name!))"
        
        return stringAmount
        
    }
    //Getters and Setters
    func setLiquidOrSolid(_ newLiquidOrSolid: String) {
        self.liquidOrSolid = newLiquidOrSolid
    }
    func setMeasurementType(_ newMeasurementType: String) {
        self.measurementType = newMeasurementType
    }
    func setAmount(_ newAmount: Dictionary<String,Int>) {
        self.amount = newAmount
    }
    func setName(_ newName: String) {
        self.name = newName
    }
    func getLiquidOrSolid() -> String? {
        return self.liquidOrSolid
        
    }
    func getName() -> String? {
        return self.name
    }
    func getAmount() -> Dictionary<String, Int>? {
        return self.amount
    }
    
    func getMeasurementType() -> String? {
        return self.measurementType
    }
}

