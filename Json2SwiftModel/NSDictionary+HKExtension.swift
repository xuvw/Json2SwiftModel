//
//  NSDictionary+HKExtension.swift
//  Json2SwiftModel
//
//  Created by heke on 16/4/20.
//  Copyright © 2016年 mhk. All rights reserved.
//

import Foundation

//MARK: Get key's correspond value
extension NSDictionary {
    
    func ext_stringValueForKey(aKey: AnyObject) -> String {
        
        let value = self.objectForKey(aKey)
        guard let realValue = value as? String else {
            print("\(value)'s type:\(value.dynamicType) is not String type will return an empty string")
            
            return ""
        }
        
        return realValue
    }
    
    func ext_floatValueForKey(aKey: AnyObject) -> Float {
        
        let value = self.objectForKey(aKey)
        guard let realValue = value as? Float else {
            print("\(value)'s type:\(value.dynamicType) is not Float type will return 0.0")
            
            return 0.0
        }
        
        return realValue
    }
    
    func ext_doubleValueForKey(aKey: AnyObject) -> Double {
        
        let value = self.objectForKey(aKey)
        guard let realValue = value as? Double else {
            print("\(value)'s type:\(value.dynamicType) is not Double type will return 0.0")
            
            return 0.0
        }
        
        return realValue
    }
    
    func ext_intValueForKey(aKey: AnyObject) -> Int {
        
        let value = self.objectForKey(aKey)
        guard let realValue = value as? Int else {
            print("\(value)'s type:\(value.dynamicType) is not Int type will return 0")
            
            return 0
        }
        
        return realValue
    }
    
    func ext_uIntValueForKey(aKey: AnyObject) -> UInt {
        
        let value = self.objectForKey(aKey)
        guard let realValue = value as? UInt else {
            print("\(value)'s type:\(value.dynamicType) is not UInt type will return 0")
            
            return 0
        }
        
        return realValue
    }
    
    func ext_boolValueForKey(aKey: AnyObject) -> Bool {
        
        let value = self.objectForKey(aKey)
        guard let realValue = value as? NSNumber else {
            print("\(value)'s type:\(value.dynamicType) is not Bool type will return false")
            
            return false
        }
        
        if realValue.isTrueBool() {
            
            return true
        } else {
            
            return false
        }
    }
    
    func ext_arrayValueForKey(aKey: AnyObject) -> NSArray {
        
        let value = self.objectForKey(aKey)
        guard let realValue = value as? NSArray else {
            print("\(value)'s type:\(value.dynamicType) is not NSArray type will return an empty array")
            
            return NSArray()
        }
        
        return realValue
    }
    
    func ext_dictionaryValueForKey(aKey: AnyObject) -> NSDictionary! {
        
        let value = self.objectForKey(aKey)
        guard let realValue = value as? NSDictionary else {
            print("\(value)'s type:\(value.dynamicType) is not NSDictionary type will return an empty dictionary")
            self.setValue(100, forKey: "")
            
            
            return NSDictionary()
        }
        
        return realValue
    }
}

/*
 key对应value类型判断
 */

enum HBCValueType {
    case vt_String
    case vt_Float
    case vt_Double
    case vt_Int
    case vt_UInt
    case vt_Bool
    case vt_NSArray //OC type
    case vt_NSDictionary //OC type
    case vt_AnyObject
    case vt_TypeNULL
}

//MARK: Get key's correspond value's type
extension NSDictionary {
    func hbc_valueTypeForKey(key: String) -> HBCValueType {
        let value = self .valueForKey(key)
        
        print(value)
        
        guard value != nil else { return .vt_TypeNULL }
        
        switch value {
            
        case let v where v is String:
            return .vt_String
            
        case let v where v is Float:
            return .vt_Float
            
        case let v where v is Double:
            return .vt_Double
            
        case let v where v is Int:
            return .vt_Int
            
        case let v where v is UInt:
            return .vt_UInt
            
        case let v where v is Bool:
            return .vt_Bool
            
        case let v where v is NSArray:
            return .vt_NSArray
            
        case let v where v is NSDictionary:
            return .vt_NSDictionary
            
        default:
            return .vt_AnyObject
        }
    }
}