//
//  ContentElement.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/25/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import Foundation

enum ContentType {
    case unknown
    case poster
    case image360
    case imageCarrousel
    case videoCarrousel
}

class ContentElement {
    var contentType:ContentType = .unknown
    var images:[String] = []
    var videos:[String] = []
    var image360:String = ""
    var posterImage:String = ""
    var classroomName:String = ""
    var building:String = ""
    var buildnumb:Int = 0
    
    init(images: [String]) {
        self.contentType = .imageCarrousel
        self.images = images
    }
    
    init(videos: [String]) {
        self.contentType = .videoCarrousel
        self.videos = videos
    }
    
    init(image360: String) {
        self.contentType = .image360
        self.image360 = image360
    }
    
    init(posterImage: String, classroomName: String, building: String, buildnumb: Int) {
        self.contentType = .poster
        self.posterImage = posterImage
        self.classroomName = classroomName
        self.building = building
        self.buildnumb = buildnumb
    }
    
}
