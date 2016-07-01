//
//  HKMainViewController.swift
//  Json2SwiftModel
//
//  Created by heke on 16/4/15.
//  Copyright © 2016年 mhk. All rights reserved.
//

import Cocoa

class HKMainViewController: NSViewController {

    @IBOutlet var leftTextView: NSTextView!
    @IBOutlet var rightTextView: NSTextView!
    @IBOutlet weak var prefixTextField: NSTextField!
    @IBOutlet weak var mainClassNameTextField: NSTextField!
    @IBOutlet weak var baseClassNameTextField: NSTextField!
    
    @IBOutlet weak var createButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftTextView.becomeFirstResponder()
    }
    
    @IBAction func copyToPasteBoard(sender: NSButton) {
        let pasteBoard = NSPasteboard.generalPasteboard()
        writeToPasteBoard(pasteBoard, stringValue: rightTextView.attributedString().string)
        
        let alert = NSAlert()
        alert.messageText = "已复制到剪贴板！！！"
        alert.addButtonWithTitle("关闭")
        alert.beginSheetModalForWindow(NSApp.keyWindow!,completionHandler: nil)
    }
    
    func writeToPasteBoard(pb: NSPasteboard, stringValue: String) {
        pb.declareTypes([NSStringPboardType], owner: self)
        pb.setString(stringValue, forType: NSStringPboardType)
    }
    
    var baseClassName: String? = nil
    
    @IBAction func doCreateAction(sender: NSButton) {
        
        self.baseClassName = nil;
        
        let rawJson = leftTextView.attributedString().string;
        let prefix = prefixTextField.attributedStringValue.string;
        let mainClassName = mainClassNameTextField.attributedStringValue.string;
        var baseClassName = baseClassNameTextField.attributedStringValue.string;
        
        if baseClassName.isEmpty {
            baseClassName = ""
        }else{
            baseClassName = ": \(baseClassName)"
        }
        self.baseClassName = baseClassName
        print(self.baseClassName!)
        
        if rawJson.isEmpty || prefix.isEmpty || mainClassName.isEmpty {
            
            let errorMessage = NSAttributedString(string: "json为空 or prefix为空 or mainClassName为空 无法生成代码")
            rightTextView.textStorage?.setAttributedString(NSAttributedString(string: ""))
            rightTextView.textStorage?.appendAttributedString(errorMessage)
            
            return;
        }
        
        var jsonDic: NSDictionary?
        do {
            
            let jsonData: NSData? = rawJson.dataUsingEncoding(NSUTF8StringEncoding)
            jsonDic = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
        }catch let anError {
            
            print(anError);
            let errorMessage = NSAttributedString(string: "json解析失败，无法生成代码")
            rightTextView.textStorage?.setAttributedString(NSAttributedString(string: ""))
            rightTextView.textStorage?.appendAttributedString(errorMessage)
            return
        }
        
        modelNames.removeAll()
        modelFiles.removeAll()
        parse(jsonDic!, mainClassName: "\(prefix)\(mainClassName)")
        
        rightTextView.textStorage?.setAttributedString(NSAttributedString(string: ""))
        for item in modelFiles {
            
            rightTextView.textStorage?.appendAttributedString(NSAttributedString(string: item))
            rightTextView.textStorage?.appendAttributedString(NSAttributedString(string: "\n\n"))
        }
    }
    
    
    // MARK:------------ PARSE DATA
    // MARK:------------ 常量部分
    let commentFlag   = "//  "
    let rn            = "\n"
    var whiteSpace    = " "
    var underLine     = "_"
    var tab           = "   "
    var jsonModelFlag = "Json2SwiftModel"
    var author        = "Created by heke"
    var copyRight     = "Copyright © 2016年 mhk. All rights reserved."
    var classFlag     = "class"
    var parseFuncName = "func parseRawData(rawData: NSDictionary?) -> Bool"
    
    var typeString    = "String?"
    var typeInt       = "Int?"
    var typeUInt      = "UInt?"
    var typeFloat     = "Float?"
    var typeDouble    = "Double?"
    var typeBool      = "Bool?"
    var typeAnyObject = "AnyObject?"
    var typeArray     = "Array"
    
    
    // MARK:------------ 常量部分
    
    var modelFiles: Array<String> = Array<String>()
    var modelNames: Array<String> = Array<String>()
    
    func parse(jsonDic: NSDictionary?, mainClassName: String) -> Bool {
        if modelNames.contains(mainClassName) {
            return true;
        }else {
            modelNames.append(mainClassName)
        }
        var parseResult = false
        
        var mainModelFile: String = ""
        
//        print("开始生成代码")
        //MARK:comment create:
        mainModelFile.appendContentsOf("\(commentFlag)\(jsonModelFlag)\(rn)\(rn)")
        mainModelFile.appendContentsOf("\(commentFlag)\(author)\(rn)")
        mainModelFile.appendContentsOf("\(commentFlag)\(copyRight)\(rn)\(rn)")
        
        //import Foundation
        mainModelFile.appendContentsOf("\("import Foundation")\(rn)\(rn)")
        
        //MARK: class body create:
        mainModelFile.appendContentsOf("\(classFlag)\(whiteSpace)\(mainClassName)\(self.baseClassName!)\(whiteSpace)\("{")\(rn)")
        
        let allKeys: Array<String>? = jsonDic?.allKeys as? Array<String>
        guard allKeys != nil && !(allKeys?.isEmpty)! else {
            mainModelFile.appendContentsOf("\(rn)\(tab)func parseRawData(rawData: NSDictionary?) -> Bool {")
            mainModelFile.appendContentsOf("\(rn)\(tab)\(tab)return true\(rn)")
            mainModelFile.appendContentsOf("\(tab)}\(rn)")
            
            mainModelFile.appendContentsOf("\("}")\(rn)")
            modelFiles.append(mainModelFile)
            
            return parseResult
        }
        
        var tempValue: AnyObject? = nil;
        
        //MARK: 成员定义生成部分
        mainModelFile.appendContentsOf("\(rn)\(tab)\(commentFlag) MARK:\("成员定义部分")\(rn)")
        for varName in allKeys! {
            
            tempValue = jsonDic?.objectForKey(varName)
            
            if tempValue is String {
                
                mainModelFile.appendContentsOf("\(tab)\("var")\(whiteSpace)\(varName)\(": ")\(typeString)\(rn)")
            }else if tempValue is NSNull {
                
                mainModelFile.appendContentsOf("\(tab)\("var")\(whiteSpace)\(varName)\(": ")\(typeAnyObject)\(rn)")
            }else if tempValue is NSNumber {
                
                guard let number = tempValue as? NSNumber else { continue }
                if number.isInt() {
                
                    mainModelFile.appendContentsOf("\(tab)\("var")\(whiteSpace)\(varName)\(": ")\(typeInt)\(rn)")
                }else if number.isUInt() {
                    number.unsignedIntegerValue
                    number.floatValue
                    number.doubleValue
                    mainModelFile.appendContentsOf("\(tab)\("var")\(whiteSpace)\(varName)\(": ")\(typeUInt)\(rn)")
                }else if number.isFloat() {
                    
                    mainModelFile.appendContentsOf("\(tab)\("var")\(whiteSpace)\(varName)\(": ")\(typeFloat)\(rn)")
                }else if number.isDouble() {
                    
                    mainModelFile.appendContentsOf("\(tab)\("var")\(whiteSpace)\(varName)\(": ")\(typeDouble)\(rn)")
                }else if number.isTrueBool() || number.isFalseBool() {
                    mainModelFile.appendContentsOf("\(tab)\("var")\(whiteSpace)\(varName)\(": ")\(typeBool)\(rn)")
                }else{
                    mainModelFile.appendContentsOf("\(tab)\("var")\(whiteSpace)\(varName)\(": ")\(typeAnyObject)\(rn)")
                }
                
            }else if tempValue is NSArray {
                let varNameNew = "\(varName)List"
                
                let subClassName = "\(mainClassName)\(underLine)\(varName)"
                mainModelFile.appendContentsOf("\(tab)\("var")\(whiteSpace)\(varNameNew)\(": ")\(typeArray)<\(subClassName)>?\(rn)")
                
                let tempArray = tempValue as! NSArray
                let tempDic = tempArray.firstObject as? NSDictionary
                
                parse(tempDic, mainClassName: subClassName)
            }else if tempValue is NSDictionary {
                
                let subClassName = "\(mainClassName)\(underLine)\(varName)"
                mainModelFile.appendContentsOf("\(tab)\("var")\(whiteSpace)\(varName)\(": ")\(subClassName)?\(rn)")
//                print(subClassName)
                parse(tempValue as? NSDictionary, mainClassName: subClassName)
            }else {
                
                mainModelFile.appendContentsOf("\(tab)\("var")\(whiteSpace)\(varName)\(": ")\(typeAnyObject)\(rn)")
            }
        }
        
        //MARK: 解析方法生成部分
        mainModelFile.appendContentsOf("\(rn)\(tab)\(commentFlag) MARK:\("解析函数定义部分")\(rn)")
        
        mainModelFile.appendContentsOf("\(tab)\(parseFuncName)\(whiteSpace)\("{")\(rn)\(rn)")
        
        mainModelFile.appendContentsOf("\(tab)\(tab)\("var parseResult = false")\(rn)")
        mainModelFile.appendContentsOf("\(tab)\(tab)\("guard rawData != nil else { return parseResult }")\(rn)\(rn)")
        
        mainModelFile.appendContentsOf("\(tab)\(tab)\("let jsonDic: NSDictionary = rawData!")\(rn)\(rn)")
        //
        var defineTempValue = false
        var defineTempArray = false
        
        for varName in allKeys! {
            tempValue = jsonDic?.objectForKey(varName)
            
            
            if tempValue is String {

                mainModelFile.appendContentsOf("\(tab)\(tab)\(varName) = jsonDic.ext_stringValueForKey(\"\(varName)\")\(rn)")
            }else if tempValue is NSNull {
                
                mainModelFile.appendContentsOf("\(tab)\(tab)\(varName) = jsonDic.objectForKey(\"\(varName)\")\(rn)\(rn)")
            }else if tempValue is NSNumber {
                
                let number = tempValue as! NSNumber
                if number.isInt() {
                    
                    mainModelFile.appendContentsOf("\(tab)\(tab)\(tab)\(varName) = jsonDic.ext_intValueForKey(\"\(varName)\")\(rn)")
                }else if number.isUInt() {
                    
                    mainModelFile.appendContentsOf("\(tab)\(tab)\(tab)\(varName) = jsonDic.ext_uIntValueForKey(\"\(varName)\")\(rn)")
                }else if number.isFloat() {
                    
                    mainModelFile.appendContentsOf("\(tab)\(tab)\(tab)\(varName) = jsonDic.ext_floatValueForKey(\"\(varName)\")\(rn)")
                }else if number.isDouble() {
                    
                    mainModelFile.appendContentsOf("\(tab)\(tab)\(tab)\(varName) = jsonDic.ext_doubleValueForKey(\"\(varName)\")\(rn)")
                }else if number.isTrueBool() || number.isFalseBool() {
                    
                    mainModelFile.appendContentsOf("\(tab)\(tab)\(tab)\(tab)\(varName) = jsonDic.ext_boolValueForKey(\"\(varName)\")\(rn)")
                }else{

                    mainModelFile.appendContentsOf("\(tab)\(tab)\(tab)\(varName) = jsonDic.objectForKey(\"\(varName)\")\(rn)")
                }
                
            }else if tempValue is NSArray {
                
                let varNameNew = "\(varName)List"
                
                let subClassName = "\(mainClassName)\(underLine)\(varName)"
                
                if !defineTempArray {
                    
                    mainModelFile.appendContentsOf("\(tab)\(tab)\("var tempArray: NSArray? = nil;")\(rn)")
                    defineTempArray = true
                }
                
                mainModelFile.appendContentsOf("\(tab)\(tab)\(varNameNew) = Array<\(subClassName)>()\(rn)")
                mainModelFile.appendContentsOf("\(tab)\(tab)tempArray = jsonDic.ext_arrayValueForKey(\"\(varName)\")\(rn)")
                mainModelFile.appendContentsOf("\(tab)\(tab)if tempArray != nil {\(rn)\(rn)")
                mainModelFile.appendContentsOf("\(tab)\(tab)\(tab)var aObjOf\(subClassName): \(subClassName)? = nil\(rn)")
                mainModelFile.appendContentsOf("\(tab)\(tab)\(tab)for tempDic in tempArray! {\(rn)\(rn)")
                
                mainModelFile.appendContentsOf("\(tab)\(tab)\(tab)\(tab)aObjOf\(subClassName) = \(subClassName)()\(rn)")
                mainModelFile.appendContentsOf("\(tab)\(tab)\(tab)\(tab)aObjOf\(subClassName)!.parseRawData(tempDic as? NSDictionary)\(rn)")
                mainModelFile.appendContentsOf("\(tab)\(tab)\(tab)\(tab)\(varNameNew)?.append(aObjOf\(subClassName)!)\(rn)")
                mainModelFile.appendContentsOf("\(tab)\(tab)\(tab)}\(rn)")
                mainModelFile.appendContentsOf("\(tab)\(tab)}\(rn)\(rn)")//end of if
                
            }else if tempValue is NSDictionary {
                
                let subClassName = "\(mainClassName)\(underLine)\(varName)"
                if !defineTempValue {
                    mainModelFile.appendContentsOf("\(tab)\(tab)\("var tempValue: NSDictionary? = nil;")\(rn)")
                    defineTempValue = true
                }

                mainModelFile.appendContentsOf("\(tab)\(tab)tempValue = jsonDic.ext_dictionaryValueForKey(\"\(varName)\")\(rn)")
                mainModelFile.appendContentsOf("\(tab)\(tab)\(varName) = \(subClassName)()\(rn)")
                mainModelFile.appendContentsOf("\(tab)\(tab)\(varName)!.parseRawData(tempValue)\(rn)\(rn)")
                
            }else {
                
                mainModelFile.appendContentsOf("\(tab)\(tab)tempValue = jsonDic.objectForKey(\"\(varName)\")\(rn)")
                mainModelFile.appendContentsOf("\(tab)\(tab)\(varName) = tempValue\(rn)\(rn)")
            }
        }
        
        mainModelFile.appendContentsOf("\(tab)\(tab)\("parseResult = true")\(rn)")
        mainModelFile.appendContentsOf("\(tab)\(tab)\("return parseResult")\(rn)")
        
        mainModelFile.appendContentsOf("\(tab)\("}")\(rn)")//parse func end
        
        mainModelFile.appendContentsOf("\("}")\(rn)")//model class end
        modelFiles.append(mainModelFile)
        
        parseResult = true
        return parseResult
    }
    // MARK:------------ PARSE DATA END
}
