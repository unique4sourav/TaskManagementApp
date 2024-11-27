//
//  ContentView.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import SwiftUI
import SwiftData

import SwiftUI

struct Contact: Identifiable {
    let id: Int // = UUID()
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
}

class ViewModel: ObservableObject {
    @Published var contacts: [Contact]
    
    static let shared = ViewModel()
    private init() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        
        let sampleData = [
            Contact(id: 1, firstName: "James", lastName: "Smith", dateOfBirth: formatter.date(from: "2-Jan-1965")!),
            Contact(id: 5, firstName: "John", lastName: "Johnson", dateOfBirth: formatter.date(from: "7-Feb-2022")!),
            Contact(id: 2, firstName: "David", lastName: "Brown", dateOfBirth: formatter.date(from: "22-Mar-1965")!),
            Contact(id: 4, firstName: "Michael", lastName: "Jones", dateOfBirth: formatter.date(from: "15-Aug-2022")!),
            Contact(id: 3, firstName: "Robert", lastName: "Davis", dateOfBirth: formatter.date(from: "11-Nov-1965")!),
        ]
        
        contacts = sampleData
    }
    
}

struct ContentView: View {
    @ObservedObject private var viewModel = ViewModel.shared
    
    private var groupedContacts:[GroupedContacts] {
        
        /// `$viewModel.contacts` is of type `Binding<[Contact]>`. We are creating an array
        /// of `Binding<Contact>` from the source `viewModel.contact`
        let contactBindingsArr = $viewModel.contacts.map {$contact in return $contact}
        
        // Group contacts by year of the dateOfBirth
        let dict = Dictionary(grouping: contactBindingsArr, by: {$item in item.dateOfBirth.formatted(.dateTime.year())})
        var arr = dict.keys.map { GroupedContacts(key: $0, contacts: dict[$0]!.sorted{$0.id > $1.id}) }
        arr.sort { $0.key > $1.key }

        return arr
    }
    
    private var filteredContacts: [Binding<Contact>] {
        
        /// `$viewModel.contacts` is of type `Binding<[Contact]>`. We are creating an array
        /// of `Binding<Contact>` from the source `viewModel.contact`
        let contactBindingsArr = $viewModel.contacts.map {$contact in return $contact}
        
        // Sort/Filter the array of Bindings
        let res = contactBindingsArr.filter{contact in ![2,4,6].contains(contact.id) }.sorted{$0.id > $1.id}
        
        return res
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                // This list shows the original data
                List {
                    ForEach(viewModel.contacts) {contact in
                        HStack {
                            Text("\(contact.id). \(contact.firstName) \(contact.lastName)")
                            Spacer()
                            Text(contact.dateOfBirth.formatted(.dateTime.year().month().day()))
                        }
                    }
                }
                .border(Color.red)
                
                // This list shows sorted/filtered data
                List {
                    ForEach(filteredContacts) {$contact in
                        HStack {
                            Text("\(contact.id). \(contact.firstName) \(contact.lastName)")
                            DatePicker("", selection: $contact.dateOfBirth, displayedComponents: [.date])
                        }
                    }
                }
                .border(Color.blue)
                
                // This list shows grouped data
                List {
                    ForEach(groupedContacts, id: \.key) {group in
                        Section(content: {
                            ForEach(group.contacts) {$contact in
                                HStack {
                                    Text("\(contact.id). \(contact.firstName) \(contact.lastName)")
                                    DatePicker("", selection: $contact.dateOfBirth, displayedComponents: [.date])
                                }
                            }
                        }, header: {Text("Year Of \(group.key)")})
                        
                    }
                }
                .border(Color.orange)
                
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("\(Image(systemName: "plus"))") {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd-MMM-yyyy"
                        let maxId = (viewModel.contacts.max {a, b in a.id < b.id})?.id ?? 0
                        let newContact = Contact(id: maxId + 1, firstName: "John", lastName: "Doe", dateOfBirth: formatter.date(from: "18-May-2022")!)
                        viewModel.contacts.append(newContact)
                    }
                }
            }
        }
    }
    
    private struct GroupedContacts {
        let key:String
        let contacts:[Binding<Contact>]
    }
}

//struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
//    }
//    
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
