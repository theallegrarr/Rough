//
//  NetworkView.swift
//  Rough
//
//  Created by nurudeen on 09/07/2021.
//

import SwiftUI

struct NetworkView: View {
    @ObservedObject var items = Remote(url: URL(string: "https://picsum.photos/v2/list")!, transform: {
        try? JSONDecoder().decode([Photo].self, from: $0)
    })
    var body: some View {
        NavigationView {
            if items.value == nil {
                ProgressView().onAppear {
                    items.load()
                }
            } else {
                List {
                    ForEach(items.value!){ photo in
                        NavigationLink(
                            destination: Text("Destination"),
                            label: {
                                Text(photo.author)
                            })
                    }
                }.navigationTitle("Authors")
            }
        }
    }
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkView()
    }
}
