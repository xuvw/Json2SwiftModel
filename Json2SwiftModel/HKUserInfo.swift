//  Json2SwiftModel

//  Created by heke
//  Copyright © 2016年 mhk. All rights reserved.

import Foundation

class HKUSerInfo_arr {
    
    //   MARK:成员定义部分
    var string: String?
    var string_null: AnyObject?
    
    //   MARK:解析函数定义部分
    func parseRawData(rawData: NSDictionary?) -> Bool {
        
        var parseResult = false
        guard rawData != nil else { return parseResult }
        
        let jsonDic: NSDictionary = rawData!
        
        string = jsonDic.ext_stringValueForKey("string")
        
        string_null = jsonDic.objectForKey("string_null")
        
        parseResult = true
        return parseResult
    }
}


//  Json2SwiftModel

//  Created by heke
//  Copyright © 2016年 mhk. All rights reserved.

import Foundation

class HKUSerInfo_dic {
    
    //   MARK:成员定义部分
    var string: String?
    var string_null: AnyObject?
    
    //   MARK:解析函数定义部分
    func parseRawData(rawData: NSDictionary?) -> Bool {
        
        var parseResult = false
        guard rawData != nil else { return parseResult }
        
        let jsonDic: NSDictionary = rawData!
        
        string = jsonDic.ext_stringValueForKey("string")
        
        string_null = jsonDic.objectForKey("string_null")
        
        parseResult = true
        return parseResult
    }
}


//  Json2SwiftModel

//  Created by heke
//  Copyright © 2016年 mhk. All rights reserved.

import Foundation

class HKUserInfo {
    
    //   MARK:成员定义部分
    var string: String?
    var int: Int?
    var double: Double?
    var string_null: AnyObject?
    var arrList: Array<HKUSerInfo_arr>?
    var dic: HKUSerInfo_dic?
    var bool_false: Bool?
    var float: Double?
    var bool_true: Bool?
    
    //   MARK:解析函数定义部分
    func parseRawData(rawData: NSDictionary?) -> Bool {
        
        var parseResult = false
        guard rawData != nil else { return parseResult }
        
        let jsonDic: NSDictionary = rawData!
        
        string = jsonDic.ext_stringValueForKey("string")
        
        int = jsonDic.ext_intValueForKey("int")
        
        double = jsonDic.ext_doubleValueForKey("double")
        
        string_null = jsonDic.objectForKey("string_null")
        
        var tempArray: NSArray? = nil;
        arrList = Array<HKUSerInfo_arr>()
        tempArray = jsonDic.ext_arrayValueForKey("arr")
        if tempArray != nil {
            
            var aObjOfHKUSerInfo_arr: HKUSerInfo_arr? = nil
            for tempDic in tempArray! {
                
                aObjOfHKUSerInfo_arr = HKUSerInfo_arr()
                aObjOfHKUSerInfo_arr!.parseRawData(tempDic as? NSDictionary)
                arrList?.append(aObjOfHKUSerInfo_arr!)
            }
        }
        
        var tempValue: NSDictionary? = nil;
        tempValue = jsonDic.ext_dictionaryValueForKey("dic")
        dic = HKUSerInfo_dic()
        dic!.parseRawData(tempValue)
        
        bool_false = jsonDic.ext_boolValueForKey("bool_false")
        
        float = jsonDic.ext_doubleValueForKey("float")
        
        bool_true = jsonDic.ext_boolValueForKey("bool_true")
        
        parseResult = true
        return parseResult
    }
}