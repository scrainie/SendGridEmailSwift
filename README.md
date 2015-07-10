# SendGridEmailSwift
Send Emails using SendGrid API and iOS Swift

Purpose:

Nice little Swift library for sending emails using SendGrid API. This is a new library and will be updated as time goes on. At this point in time, it can send emails with many tos, to, bbc, images, and file attachements. This uses the same process as the original Objective-C library made by SendGrid.

Requirements:

AFNetworking - https://github.com/AFNetworking/AFNetworking

json.swift - https://github.com/owensd/json-swift

How to Use:

Simply install the above AFNetworking and json.swift libraries. These are required for the SendGridEmailSwift library to work. Drag and drop the SendGridEmailSwift.swift file to your project.


Send Basic Email

			let sendgrid = SendGridEmailSwift(sendGridUser: "USERNAME", sendGridAPI: "PASSWORD")
         
            sendgrid.from = "email@emailaddress.com"
            sendgrid.fromName = "My SendGrid"
            sendgrid.subject = "Email Subject"
            sendgrid.text = "Message in here...."
            
            sendgrid.sendEmail({ (response) -> Void in
                
                println(response)
          
                
            }, failure: { (error) -> Void in
                
                println(error)
                
            })

Send Email with Image

			let sendgrid = SendGridEmailSwift(sendGridUser: "USERNAME", sendGridAPI: "PASSWORD")
         
            sendgrid.from = "email@emailaddress.com"
            sendgrid.fromName = "My SendGrid"
            sendgrid.subject = "Email Subject"
            sendgrid.inlineImage = true
            sendgrid.attachImage(UIImage(named: "imagename")!)
            sendgrid.html = "<html><img src =\"cid:image0.png\"></html>"
            
            sendgrid.sendEmail({ (response) -> Void in
                
                println(response)
          
                
            }, failure: { (error) -> Void in
                
                println(error)
                
            })

Send Email with Attachment
			
			let fileAttachment = SendAttachmentSwift()
        
            //Prepare Attachement
            fileAttachment.filename = "filetosend"
            fileAttachment.extensionType = "csv"
            fileAttachment.mimeType = "text/csv"
            let path = NSBundle.mainBundle().pathForResource("filetosend", ofType: "csv")
            if let myData = NSData(contentsOfFile: path!) {
            
            fileAttachment.attachmentData = myData          

        	//Prepare Email
       		let sendgrid = SendGridEmailSwift(sendGridUser: "USERNAME", sendGridAPI: "PASSWORD")
        
       		sendgrid.to = "emailaddress@emailaddress.com"
          	sendgrid.from = "emailaddress@emailaddress.com"
        	sendgrid.fromName = "My SendGrid Email"
            sendgrid.subject = "Subject here..."
        	sendgrid.text = "CSV File"
        	sendgrid.attachFile(fileAttachment)
        	sendgrid.sendEmailWithAttachment({ (response) -> Void in
            
            println(response)
            
            
            }, failure: { (error) -> Void in
                
                println(error)
               
       		})


Send Email with Multiple Emails

			var emails = ["email1@email1.com", "email2@email2.com", "email3@email3.com", "email4@email4.com"]

			let sendgrid = SendGridEmailSwift(sendGridUser: "USERNAME", sendGridAPI: "PASSWORD")
            
            sendgrid.tos = emails
            sendgrid.from = "email@emailaddress.com"
            sendgrid.fromName = "My SendGrid"
            sendgrid.subject = "Email Subject"
            sendgrid.text = "Message in here...."
            
            sendgrid.sendEmail({ (response) -> Void in
                
                println(response)
          
                
            }, failure: { (error) -> Void in
                
                println(error)
                
            })


Email Elements 
			
			let sendgrid = SendGridEmailSwift(sendGridUser: "USERNAME", sendGridAPI: "PASSWORD")
			sendgrid.bcc
			sendgrid.tos
            sendgrid.from
            sendgrid.fromName
            sendgrid.subject
            sendgrid.text
            sendgrid.html

        

