//  Json2SwiftModel

//  Created by heke
//  Copyright © 2016年 mhk. All rights reserved.

import Foundation

class HKDemo_batters_batter {
    
    //  成员定义部分
    
    var id: String?
    var type: String?
    
    //  解析函数定义部分
    
    func parseRawData(rawData: NSDictionary?) -> Bool {
        
        guard rawData != nil else { return false }
        var parseResult = false
        let allKeys: [String]? = rawData!.allKeys as? [String]
        guard allKeys != nil && allKeys?.count>0 else {
            parseResult = true
            return parseResult
        }
        
        let jsonDic: NSDictionary = rawData!
        var tempValue: AnyObject? = nil;
        var number: NSNumber? = nil;
        var tempArray: NSArray? = nil;
        tempValue = jsonDic.objectForKey("id")
        id = tempValue as? String
        
        tempValue = jsonDic.objectForKey("type")
        type = tempValue as? String
        
        parseResult = true
        return parseResult
    }
    
}

//  Json2SwiftModel

//  Created by heke
//  Copyright © 2016年 mhk. All rights reserved.

import Foundation

class HKDemo_batters {
    
    //  成员定义部分
    
    var batterList: Array<HKDemo_batters_batter>?
    
    //  解析函数定义部分
    
    func parseRawData(rawData: NSDictionary?) -> Bool {
        
        guard rawData != nil else { return false }
        var parseResult = false
        let allKeys: [String]? = rawData!.allKeys as? [String]
        guard allKeys != nil && allKeys?.count>0 else {
            parseResult = true
            return parseResult
        }
        
        let jsonDic: NSDictionary = rawData!
        var tempValue: AnyObject? = nil;
        var number: NSNumber? = nil;
        var tempArray: NSArray? = nil;
        tempValue = jsonDic.objectForKey("batter")
        batterList = Array<HKDemo_batters_batter>()
        tempArray = tempValue as? NSArray
        if tempArray != nil {
            var aObjOfHKDemo_batters_batter: HKDemo_batters_batter? = nil
            for tempDic in tempArray! {
                aObjOfHKDemo_batters_batter = HKDemo_batters_batter()
                aObjOfHKDemo_batters_batter!.parseRawData(tempDic as? NSDictionary)
                batterList?.append(aObjOfHKDemo_batters_batter!)
            }
            
        }
        
        parseResult = true
        return parseResult
    }
    
}

//  Json2SwiftModel

//  Created by heke
//  Copyright © 2016年 mhk. All rights reserved.

import Foundation

class HKDemo_topping {
    
    //  成员定义部分
    
    var id: String?
    var type: String?
    
    //  解析函数定义部分
    
    func parseRawData(rawData: NSDictionary?) -> Bool {
        
        guard rawData != nil else { return false }
        var parseResult = false
        let allKeys: [String]? = rawData!.allKeys as? [String]
        guard allKeys != nil && allKeys?.count>0 else {
            parseResult = true
            return parseResult
        }
        
        let jsonDic: NSDictionary = rawData!
        var tempValue: AnyObject? = nil;
        var number: NSNumber? = nil;
        var tempArray: NSArray? = nil;
        tempValue = jsonDic.objectForKey("id")
        id = tempValue as? String
        
        tempValue = jsonDic.objectForKey("type")
        type = tempValue as? String
        
        parseResult = true
        return parseResult
    }
    
}

//  Json2SwiftModel

//  Created by heke
//  Copyright © 2016年 mhk. All rights reserved.

import Foundation

class HKDemo {
    
    //  成员定义部分
    
    var id: String?
    var batters: HKDemo_batters?
    var toppingList: Array<HKDemo_topping>?
    var type: String?
    var name: String?
    var ppu: Double?
    
    //  解析函数定义部分
    
    func parseRawData(rawData: NSDictionary?) -> Bool {
        
        guard rawData != nil else { return false }
        var parseResult = false
        let allKeys: [String]? = rawData!.allKeys as? [String]
        guard allKeys != nil && allKeys?.count>0 else {
            parseResult = true
            return parseResult
        }
        
        let jsonDic: NSDictionary = rawData!
        var tempValue: AnyObject? = nil;
        var number: NSNumber? = nil;
        var tempArray: NSArray? = nil;
        tempValue = jsonDic.objectForKey("id")
        id = tempValue as? String
        
        tempValue = jsonDic.objectForKey("batters")
        batters = HKDemo_batters()
        batters!.parseRawData(tempValue as? NSDictionary)
        
        tempValue = jsonDic.objectForKey("topping")
        toppingList = Array<HKDemo_topping>()
        tempArray = tempValue as? NSArray
        if tempArray != nil {
            var aObjOfHKDemo_topping: HKDemo_topping? = nil
            for tempDic in tempArray! {
                aObjOfHKDemo_topping = HKDemo_topping()
                aObjOfHKDemo_topping!.parseRawData(tempDic as? NSDictionary)
                toppingList?.append(aObjOfHKDemo_topping!)
            }
            
        }
        
        tempValue = jsonDic.objectForKey("type")
        type = tempValue as? String
        
        tempValue = jsonDic.objectForKey("name")
        name = tempValue as? String
        
        tempValue = jsonDic.objectForKey("ppu")
        number = tempValue as? NSNumber
        
        if number != nil {
            
            ppu = number!.doubleValue
            
        }
        
        parseResult = true
        return parseResult
    }
    
}

