//
//  GetWallpapersCategoriesRequest.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 26.04.2024.
//

import Alamofire

struct GetWallpapersCategoriesRequest: APIRequestBody {
    var url: String {
        GlobalDefinitions.domain + "/api/categories/list"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey
        ]
    }
}
