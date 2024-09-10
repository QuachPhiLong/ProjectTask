//
//  TaskCDModel.swift
//  DreamerlyTest
//
//  Created by Long Quách on 09/09/2024.
//

import CoreStore

class TaskCDModel: CoreStoreObject {
    @Field.Stored("title")
    var title: String = ""
    
    @Field.Stored("id")
    var id: String = ""

    @Field.Stored("desc")
    var desc: String = ""
    
    @Field.Stored("status")
    var status: String = ""
    
    @Field.Stored("tag")
    var tag: String = ""
    
    @Field.Stored("date")
    var date: Date?
    
    @Field.Stored("isRemind")
    var isRemind: Bool?
    
    @Field.Stored("taskType")
    var taskType: String?
    
}
