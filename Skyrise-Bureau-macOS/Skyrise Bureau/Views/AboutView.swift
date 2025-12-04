//
//  AboutView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 23/11/25.
//

import SwiftUI

struct AboutView: View {
    let preRealease: Bool = false
    let version: String = "1.1"
    @Environment(\.openURL) var openURL
    var body: some View {
        VStack {
            HStack {
                Image("AboutIcon")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding()
                VStack {
                    if preRealease {
                        Text("Skyrise Bureau (⍺)")
                            .font(.largeTitle)
                            .fontWidth(.expanded)
                        +
                        Text("\nv\(version) (\(Bundle.main.buildNumber))")
                            .font(.title3)
                            .fontWidth(.expanded)
                        +
                        Text(" - pre-release")
                            .fontWidth(.condensed)
                    } else {
                        Text("Skyrise Bureau")
                            .font(.largeTitle)
                            .fontWidth(.expanded)
                        +
                        Text("\nv\(version)")
                            .font(.title3)
                            .fontWidth(.expanded)
                    }
                    Button {
                        if let url = URL(string: "https://github.com/advaitconty/Skyrise-Bureau") {
                            openURL(url)
                        }
                    } label: {
                        HStack(spacing: 5) {
                            Image("GithubLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 15)
                            Text("Contribute on GitHub")
                                .fontWidth(.condensed)
                        }
                    }
                }
            }
            Text("Made with 💚 by ")
                .fontWidth(.condensed)
            +
            Text("@advaitconty")
                .fontWidth(.condensed)  
        }
        .padding()
    }
}

#Preview {
    AboutView()
}
