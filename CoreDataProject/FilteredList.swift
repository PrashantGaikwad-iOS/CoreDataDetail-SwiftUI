

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    //var fetchRequest: FetchRequest<Singer>
    //var singers: FetchedResults<Singer> { fetchRequest.wrappedValue }
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            //Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            self.content(singer)
        }
    }
    
//    init(filter: String) {
//        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
//    }
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}
