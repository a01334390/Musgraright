//
//  NetworkActionsController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/25/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

class NetworkActionsController {
    static func downloadImage(_ url: URL, completionBlock: @escaping (_ success: NSURL?) -> Void) {
        SVProgressHUD.show(withStatus:"Downloading Image")
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent(url.lastPathComponent)
            return (documentsURL,[.removePreviousFile])
        }
        
        Alamofire.download(url, to: destination).responseData { response in
            SVProgressHUD.dismiss()
            if let destinationUrl = response.destinationURL {
                completionBlock(destinationUrl as NSURL)
            } else {
                completionBlock(nil)
            }
        }
    }
    
    static func downloadFile(_ url: URL, completionBlock: @escaping (_ success: NSURL?) -> Void) {
        SVProgressHUD.show(withStatus:"Downloading File")
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent(url.lastPathComponent)
            return (documentsURL,[.removePreviousFile])
        }
        
        Alamofire.download(url, to: destination).responseData { response in
            SVProgressHUD.dismiss()
            if let destinationUrl = response.destinationURL {
                completionBlock(destinationUrl as NSURL)
            } else {
                completionBlock(nil)
            }
        }
    }
    
    static func saveImage(imageName: String, image: UIImage) -> NSURL {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return NSURL() }
        
        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return NSURL() }
        
        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
            
        }
        
        do {
            try data.write(to: fileURL)
            return fileURL as NSURL
        } catch let error {
            print("error saving file with error", error)
        }
        
        return NSURL()
    }
}
