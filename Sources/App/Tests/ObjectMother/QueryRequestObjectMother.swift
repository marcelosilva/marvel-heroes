//
//  QueryRequestObjectMother.swift
//  
//
//  Created by Marcelo Silva on 22/4/22.
//

import Foundation
import App

class QueryRequestObjectMother {
    var limit = 20
    var offset = 0
    var search = "search"
    var sorting = "name"
    
    func withLimit(limit: Int) -> QueryRequestObjectMother {
        self.limit = limit
        return self
    }
    
    func withOffset(offset: Int) -> QueryRequestObjectMother {
        self.offset = offset
        return self
    }
    
    func withSearch(search: String) -> QueryRequestObjectMother {
        self.search = search
        return self
    }
    
    func withSorting(sorting: String) -> QueryRequestObjectMother {
        self.sorting = sorting
        return self
    }
    
    func build() -> QueryRequest {
        QueryRequest(
            limit: limit,
            offset: offset,
            search: search,
            sorting: sorting
        )
    }
    
}
