//
//  NSDictionary+HKExtension.swift
//  Json2SwiftModel
//
//  Created by heke on 16/4/20.
//  Copyright © 2016年 mhk. All rights reserved.
//

import Foundation

/*
 key对应value提取
 String
 Float
 Double
 Int
 Uint
 Bool
 NSArray
 NSDictionary
 */
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
            
            return NSDictionary()
        }
        
        return realValue
    }
}

/*
 key对应value类型判断
 */

enum ValueType {
    case vt_String
    case vt_Float
    case vt_Double
    case vt_Int
    case vt_UInt
    case vt_Bool
    case vt_NSArray //OC type
    case vt_NSDictionary //OC type
    case vt_AnyObject
}

extension NSDictionary {
    
}