//
//  NotesModel.swift
//  Hiker
//
//  Created by 张驰 on 2019/9/23.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation
import HandyJSON

struct HKStory:HandyJSON {
    var msg:String?
    var code:String?
    var data:[StoryModel]?
}
struct StoryModel:HandyJSON {
    var bookname = ""
    var story:[NotesModel]?
}

struct HomeModel: HandyJSON {
    var msg:String?
    var code:String?
    var data:[NotesModel]?
}

struct NotesModel:HandyJSON {
    var id = 0
    var content = ""
    var user:User?
    var type = 0
    var pics: [String]?
    var time = ""
    var locations: [String]?
    var comments:[Comments]?
    var title = ""
    var likes = 0
    var like = false
    var collected = false
    var notePares:[NoteParas]?
}
struct User:HandyJSON {
    var id = ""
    var username = ""
    var password = ""
    var headPic = ""
}
struct Comments:HandyJSON {
    var id = ""
    var content = ""
    var user:User?
    var type = ""
    var pics = ""
}
struct NoteParas:HandyJSON {
    var id = ""
    var content = ""
    var pic = ""
    var place = ""
    var date = ""
    var noteid = ""
}

