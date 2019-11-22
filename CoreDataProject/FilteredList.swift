

import CoreData
import SwiftUI

enum predicateOptions {
    case beginsWithString
    case containsString
    case equalsTo
}

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
    init(filterKey: String, filterValue: String, predictionOptions: predicateOptions, predicateKey: String, sortArray:[NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content) {
        //fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [sortArray], predicate: NSPredicate(format: "%K CONTAINS[c] %@", filterKey, filterValue))
        
        var predicateValue: String {
            switch predictionOptions{
            case .beginsWithString:
                return "BEGINSWITH"
            case .containsString:
                return "CONTAINS"
            default:
                return "=="
            }
        }
        
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortArray, predicate: NSPredicate(format: "lastName \(predicateValue) %@", predicateKey))
        self.content = content
    }
}
