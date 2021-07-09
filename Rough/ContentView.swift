//
//  ContentView.swift
//  Rough
//
//  Created by nurudeen on 05/06/2021.
//

import SwiftUI

struct ContentView: View {
    @State var loading: Bool = false
    @State var error: String = ""
    @State var searchQuery: String = ""
    @State var movieList  = [MovieObject]()
    @State var apiKey = "45e413b8"
    @State var done = false
    
    var body: some View {
        VStack {
            NetworkView()
            TextField("Enter the Movie Name", text: self.$searchQuery)
                .padding(30)
                .multilineTextAlignment(.center)
            
            if(!loading){
                Button(action: {
                    withAnimation {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                        self.action()
                    }
                }){
                    Text("Search")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                        .padding(20)
                        .padding([.leading, .trailing], 30)
                }.background(Color.blue)
                .cornerRadius(15)
            } else {
                Text("...loading")
            }
            if(movieList.count>0){
                ScrollView {
                    ForEach(movieList, id: \.imdbID) { movie in
                        VStack {
                            Text(movie.Title)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
            } else if movieList.count == 0 && done == true {
                Text("no movies found")
            }
            Spacer()
        }
    }
    
    func action(){
        self.loading = true
        self.error = ""
        
        guard let url = URL(string: "https://www.omdbapi.com/?i=tt3896198&apikey="+self.apiKey+"&s="+self.searchQuery)
            else {
                return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){ (data, response, error) in
            guard let data = data else { return }
            do {
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
                if statusCode == 200 {
                    let finalData = try JSONDecoder().decode(IMDBSearchResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.loading = false
                        self.movieList = finalData.Search
                    }
                }
            } catch {
                self.loading = false
                self.error = "an error occured"
                print(error)
                
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
