//
//  NSNumber+HKExts.swift
//  HBCTools
//
//  Created by heke on 16/4/14.
//  Copyright © 2016年 mhk. All rights reserved.
//

import Foundation

extension NSNumber {
    internal func isTrueBool() -> Bool {
        
        let value = NSNumber(bool: true)
        let valueCType = String.fromCString(value.objCType)
        let selfCType = String.fromCString(self.objCType)
        
        if (self.compare(value) == NSComparisonResult.OrderedSame) && selfCType == valueCType {
            return true;
        }
        
        return false
    }
    
    internal func isFalseBool() -> Bool {
        
        let value = NSNumber(bool: false)
        let valueCType = String.fromCString(value.objCType)
        let selfCType = String.fromCString(self.objCType)
        
        if (self.compare(value) == NSComparisonResult.OrderedSame) && selfCType == valueCType {
            return true;
        }
        
        return false
    }
    
    internal func isFloat() -> Bool {
        
        let value = NSNumber(float: 1.11)
        let valueCType = String.fromCString(value.objCType)
        let selfCType = String.fromCString(self.objCType)
        
        if selfCType == valueCType {
            return true;
        }
        
        return false
    }
    
    internal func isDouble() -> Bool {
        
        let value = NSNumber(double: 1.111111111111)
        let valueCType = String.fromCString(value.objCType)
        let selfCType = String.fromCString(self.objCType)
        
        if selfCType == valueCType {
            return true;
        }
        
        return false
    }
    
    internal func isInt() -> Bool {
        
        let value = NSNumber(integer: Int.max)
        let valueCType = String.fromCString(value.objCType)
        let selfCType = String.fromCString(self.objCType)
        
        if selfCType == valueCType {
            return true;
        }
        
        return false
    }
    
    internal func isUInt() -> Bool {
        
        let value = NSNumber(unsignedInteger: UInt.max)
        let valueCType = String.fromCString(value.objCType)
        let selfCType = String.fromCString(self.objCType)
        
        if selfCType == valueCType {
            return true;
        }
        
        return false
    }
}