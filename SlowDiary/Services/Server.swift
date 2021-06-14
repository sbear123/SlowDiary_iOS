//
//  Server.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/03.
//

import Foundation
import Alamofire
import SwiftyJSON

class Server {
    let sUrl = "http://10.80.161.67:3000"
    
    func GET(api: String, param: Dictionary<String, Any>) -> DataRequest {
        let apiUrl = sUrl + api
        print(apiUrl)
        
        return AF.request(apiUrl,
                          method: .get,
                          parameters: param,
                          encoding: URLEncoding.queryString)
            .validate(statusCode: 200..<400)
    }
    
    func POST(api: String, param: Dictionary<String, Any>) -> DataRequest {
        let apiUrl = sUrl + api
        print(apiUrl)
        
        return AF.request(apiUrl,
                          method: .post,
                          parameters: param,
                          encoding: JSONEncoding.default)
            .validate(statusCode: 200..<400)
    }
    
    func DELETE(api: String, param: Dictionary<String, Any>) -> DataRequest {
        let apiUrl = sUrl + api
        print(apiUrl)
        
        return AF.request(apiUrl,
                          method: .delete,
                          parameters: param,
                          encoding: JSONEncoding.default)
            .validate(statusCode: 200..<400)
    }
    
    func PATCH(api: String, param: Dictionary<String, Any>) -> DataRequest {
        let apiUrl = sUrl + api
        print(apiUrl)
        
        return AF.request(apiUrl,
                          method: .patch,
                          parameters: param,
                          encoding: JSONEncoding.default)
            .validate(statusCode: 200..<400)
    }
    
    func UPLOAD(api: String, param: Dictionary<String, Any>, pic: UIImage) -> DataRequest {
        let apiUrl = sUrl + api
        print(apiUrl)
        let img = pic.jpegData(compressionQuality: 1)!
        let headers: HTTPHeaders = ["Content-type" : "multipart/form-data"]
        return AF.upload(multipartFormData: { multiPart in
            for (key, value) in param {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            multiPart.append(img, withName: "image", fileName: "\(param["id"]!).jpg", mimeType: "image/jpeg")
        }, to: apiUrl, method: .post, headers: headers)
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("upload")
        })
    }
}
