//
//  SDWebImageBootcamp.swift
//  SPMs&SDKs
//
//  Created by Валерий Зазулин on 26.03.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoader: View {
    
    let url: String
    var contentMode: ContentMode = .fill
    
    var body: some View {
        Rectangle().opacity(0)
        .overlay {
            SDWebImageLoader(url: url, contentMode: contentMode)
                .allowsHitTesting(false)
        }
        .clipped()
    }
}

fileprivate struct SDWebImageLoader: View {
    
    let url: String
    var contentMode: ContentMode = .fill
    
    var body: some View {
        WebImage(url: URL(string: url))
            .onSuccess(perform: { image, data, cacheType in
                //
            })
            .onFailure(perform: { error in
                //
            })
            //.placeholder(Image(systemName: "photo")) // Placeholder Image
            .placeholder {
                Color.gray.opacity(0.3)
            }
            .resizable()
            .aspectRatio(contentMode: contentMode)
    }
}

final class ImagePrefetcher {
    static let instance = ImagePrefetcher()
    private let prefetcher = SDWebImagePrefetcher()
    
    private init() {}
    
    func startPrefetching(urls: [URL]) {
        prefetcher.prefetchURLs(urls)
    }
    
    func stopPrefetching() {
        prefetcher.cancelPrefetching()
    }
}

struct SDWebImageBootcamp: View {
    
    var body: some View {
            ImageLoader(
                url: "https://picsum.photos/id/237/200/300",
                contentMode: .fill
            )
            .frame(width: 200, height: 200)
            .onAppear {
                ImagePrefetcher.instance.startPrefetching(urls: [/* ulrs */]) // URLs list for prefetching
            }
    }
}

#Preview {
    SDWebImageBootcamp()
}
