//
//  HBCFeedItemModel.swift
//  Json2SwiftModel
//
//  Created by heke on 16/4/16.
//  Copyright © 2016年 mhk. All rights reserved.
//

import Cocoa

class HBCFeedItemModel: HBCBaseModel {
    
    var list: Array<AnyObject>?
    var productItem: HBCProductItem?
    var address: String?
    var aStringValue: String?
    var aBoolValue: Bool?
    var aIntValue: Int?
    var aUIntValue: UInt?
    var aFloatValue: Float?
    var aDoubleValue: Double?
    
    override func parseRawData(rawData: NSDictionary?) -> Bool {
        
        guard rawData != nil else { return false }
        
        var parseResult = false
        
        let allKeys: [String]? = rawData!.allKeys as? [String]
        
        for item in allKeys! {
            
            let obj: AnyObject? = rawData![item]
            guard obj != nil else { continue }
            
            if obj is Array<NSDictionary> {// 数组解析,前提：字典格式一致
                
                let aArrayDic = obj as! Array<NSDictionary>
                list = Array<AnyObject>()
                
                for aTempDic in aArrayDic {
                    
                    let aProduct: HBCProductItem = HBCProductItem()
                    parseResult = aProduct.parseRawData(aTempDic)
                    
                    if !parseResult {
                        return parseResult
                    }
                    
                    list!.append(aProduct)
                }
            }else if obj is NSDictionary {//字典解析
                
                productItem = HBCProductItem()
                parseResult = productItem!.parseRawData(obj as? NSDictionary)
                if !parseResult {
                    return parseResult
                }
            }else if obj is NSNumber{//标量解析
                
                let aNumber = obj as! NSNumber
                
                if aNumber.isInt() {
                    
                    aNumber.integerValue;
                }else if aNumber.isUInt(){
                    
                    aNumber.unsignedIntegerValue
                }else if aNumber.isFloat(){
                    
                    aNumber.floatValue
                }else if aNumber.isDouble(){
                    
                    aNumber.doubleValue
                }else if aNumber.isTrueBool(){
                    
                    true
                }else if aNumber.isFalseBool(){
                    
                    false
                }else{
                    
                    print("unKown Type 😁")
                }
            }else if obj is NSNull {
                
                //直接赋值nil即可
            }else if obj is String {
                
                let aString = obj as! String
                aStringValue = aString
            }
        }
        
        return parseResult
    }
}

class HBCProductItem: HBCBaseModel {
    var key: String?
    
    override func parseRawData(rawData: NSDictionary?) -> Bool {
        key = "aValue"
        return true
    }
}
