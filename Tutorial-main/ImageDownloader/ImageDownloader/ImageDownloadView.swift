//
//  ImageDownloadView.swift
//  ImageDownloader
//
//  Created by Rajkumar Yadav on 31/07/26.
//

import SwiftUI

struct ImageDownloadView: View {
    let urls: [URL] = [
        URL(string: "https://fastly.picsum.photos/id/1/200/300.jpg?hmac=jH5bDkLr6Tgy3oAg5khKCHeunZMHq0ehBZr6vGifPLY")!,
        URL(string: "https://fastly.picsum.photos/id/2/200/300.jpg?hmac=HiDjvfge5yCzj935PIMj1qOf4KtvrfqWX3j4z1huDaU")!,
        URL(string: "https://fastly.picsum.photos/id/3/200/300.jpg?hmac=o1-38H2y96Nm7qbRf8Aua54lF97OFQSHR41ATNErqFc")!,
        URL(string: "https://fastly.picsum.photos/id/4/200/300.jpg?hmac=y6_DgDO4ccUuOHUJcEWirdjxlpPwMcEZo7fz1MpuaWg")!,
        URL(string: "https://fastly.picsum.photos/id/5/200/300.jpg?hmac=1TWjKFT7_MRP0ApEyDUA3eCP0HXaKTWJfHgVjwGNoZU")!,
        URL(string: "https://fastly.picsum.photos/id/6/200/300.jpg?hmac=a4Gfsl7hyAvOnmQtzoEkQmbiLJFl7otISIdoYQWqJCo")!,
        URL(string: "https://fastly.picsum.photos/id/7/200/300.jpg?hmac=_vgE8dZdzp3B8T1C9VrGrIMBkDOkFYbJNWqzJD47xNg")!,
        URL(string: "https://fastly.picsum.photos/id/8/200/300.jpg?hmac=t2Camsbqc4OfjWMxFDwB32A8N4eu7Ido7ZV1elq4o5M")!,
        URL(string: "https://fastly.picsum.photos/id/9/200/300.jpg?hmac=BguC5kAGl-YR4FEjhjm0b2XWbynYsk3s3QQZUie5aBo")!,
        URL(string: "https://fastly.picsum.photos/id/10/200/300.jpg?hmac=94QiqvBcKJMHpneU69KYg2pky8aZ6iBzKrAuhSUBB9s")!,
        URL(string: "https://fastly.picsum.photos/id/11/200/300.jpg?hmac=n9AzdbWCOaV1wXkmrRfw5OulrzXJc0PgSFj4st8d6ys")!
        
    ]
    
    let imageDownloder = ImageDownloader()
    
    var body: some View {
        VStack {
            VStack{
                Button {
                    Task{
                        await imageDownloder.downloadImages(from: urls)
                    }
                } label: {
                   Text("Start Download")
                }

            }
        }
        .padding()
    }
}

#Preview {
    ImageDownloadView()
}
