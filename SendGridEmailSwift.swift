//
//  SendGridEmail.swift
//  ArrivalDesk
//
//  Created by Stewart Crainie on 9/07/2015.
//  Copyright (c) 2015 Stewart Crainie. All rights reserved.
//

import UIKit
import Foundation



public class SendAttachmentSwift: NSObject {
    
    var attachmentData:NSData!
    var mimeType:String!
    var filename:String!
    var extensionType:String!
    
}

public class SendGridEmailSwift {

    public var baseURL = "https://api.sendgrid.com/api/"
    public var apiURL = "mail.send.json"
    
    var sgUser: String!
    var sgAPI: String!
    
    var encoderHeader:String!
    var xsmtpapi:String!
    var parameters = [String:AnyObject]()
    
    public var subject:String!
    public var from:String!
    public var html:String!
    public var bcc:String!
    public var tos:[AnyObject] = [AnyObject]()
    public var to:AnyObject!
    public var text:String!
    public var fromName:String!
    public var img:[AnyObject] = [AnyObject]()
    public var attachments:[AnyObject] = [AnyObject]()
    public var inlineImage = false
    
    init(sendGridUser:String, sendGridAPI:String) {
        
            self.sgUser = sendGridUser
            self.sgAPI = sendGridAPI
        
    }
    
    
    
    public func attachImage(image:UIImage) {
        
        self.img.append(image)
        println(self.img)
        
    }
    
    
    public func attachFile(attachment:SendAttachmentSwift) {
        
        self.attachments.append(attachment)
        
    }
    

    public func sendEmail(success: (response: AnyObject!) -> Void, failure: (error: NSError?) -> Void) {
    
        let manager = AFHTTPRequestOperationManager()
        
        if to == nil && tos.count > 0 {
            to = tos
        }else {
            
            println("No Emails")
            
        }
        
        if self.text == nil && self.html != nil {
            self.text = self.html
        }
        
        parameters = [
                        "api_user": self.sgUser,
                        "api_key": self.sgAPI,
                        "subject":self.subject,
                        "from":self.from,
                        "html":self.html,
                        "text":self.text,
                        "to":to]

        if tos.count > 0 {
            parameters["x-smtpapi"] = self.encode(tos)
        }
        if bcc != nil {
            parameters["bcc"] = self.bcc
        }
        if fromName != nil {
            parameters["fromname"] = self.fromName
        }
        if inlineImage.boolValue == true {
         
            
            for var i = 0; i < img.count; i++ {
                
                var filename = "image\(i).png"
                var key = "content[image\(i).png]"
                parameters[key] = filename
                
                println(filename)
                
            }
            
        }
        
        manager.POST(self.getURL(), parameters: parameters, constructingBodyWithBlock: { (formData:AFMultipartFormData!) -> Void in
            
            
            for var i = 0; i < self.img.count; i++ {
           
                var imgd = self.img[i] as! UIImage
                var filename = "image\(i).png"
                var name = "files[image\(i).png]"
                var imageData = NSData(data: UIImagePNGRepresentation(imgd))
                
                
                formData.appendPartWithFileData(imageData, name: name, fileName: filename, mimeType: "image/png")
                
    
            }

            
            
            
            }, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
            
                success(response: responseObject)
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
            
                failure(error: error)
                println("Error: " + error.localizedDescription)
            
        }
        
        
    }
    
    public func sendEmailWithAttachment(success: (response: AnyObject!) -> Void, failure: (error: NSError?) -> Void) {
        
        let manager = AFHTTPRequestOperationManager()
        
        if to == nil && tos.count > 0 {
            to = tos
        }
        
        if self.text == nil && self.html != nil {
            self.text = self.html
        }
        
        parameters = [
            "api_user": self.sgUser,
            "api_key": self.sgAPI,
            "subject":self.subject,
            "from":self.from,
            "html":self.html,
            "text":self.text,
            "to":to]
        
        if tos.count > 0 {
            parameters["x-smtpapi"] = self.encode(tos)
        }
        if bcc != nil {
            parameters["bcc"] = self.bcc
        }
        if fromName != nil {
            parameters["fromname"] = self.fromName
        }
        if inlineImage.boolValue == true {
            
            
            for var i = 0; i < img.count; i++ {
                
                var filename = "image\(i).png"
                var key = "content[image\(i).png]"
                parameters[key] = filename
                
                println(filename)
                
            }
            
        }
        manager.POST(self.getURL(), parameters: parameters, constructingBodyWithBlock: { (formData:AFMultipartFormData!) -> Void in
            
            
            for var i = 0; i < self.img.count; i++ {
                
                var imgd = self.img[i] as! UIImage
                var filename = "image\(i).png"
                var name = "files[image\(i).png]"
                var imageData = NSData(data: UIImagePNGRepresentation(imgd))
                
                
                formData.appendPartWithFileData(imageData, name: name, fileName: filename, mimeType: "image/png")
                
                
            }

            for var i = 0; i < self.attachments.count; i++ {
                
                var attachmentR = self.attachments[i] as! SendAttachmentSwift
                var attachmentDataR = NSData(data: attachmentR.attachmentData)
                var mimeTypeR = attachmentR.mimeType
                var filenameR = "\(attachmentR.filename).\(attachmentR.extensionType)"
                var nameR = "files[\(attachmentR.filename).\(attachmentR.extensionType)]"
                formData.appendPartWithFileData(attachmentDataR, name: nameR, fileName: filenameR, mimeType: mimeTypeR)
                
            }
            
            }, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
                
                success(response: responseObject)
                
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                
                failure(error: error)
                println("Error: " + error.localizedDescription)
                
        }
        
        
    }

    func getURL () ->String {
        
        var url = "\(self.baseURL)\(self.apiURL)"
        
        return url
    }
    
    func encode (header:AnyObject) -> String  {
        
        let obj:[String:AnyObject] = [
            "to":header
        ]
        
        let json = JSON(obj)
        json.toString()
        
        return json.toString()

    }

}