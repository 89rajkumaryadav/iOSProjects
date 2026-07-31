//
//  ImageDownloader.swift
//  ImageDownloader
//
//  Created by Rajkumar Yadav on 31/07/26.
//

import Foundation

actor ImageDownloader {
    private let filemanager: FileManager
    
    init(filemanager: FileManager = .default) {
        self.filemanager = filemanager
    }
    
    func downloadImages(from urls: [URL]) async {
        print("Download started")
        await withTaskGroup(of: Void.self){ group in
            
            // Limit concurrent downloads
            let maxConcurrentDownloads: Int = 2
            var iterator = urls.enumerated().makeIterator()
            
            for _ in 0..<maxConcurrentDownloads {
                guard let (index, url) = iterator.next() else { break }
                group.addTask {
                    await self.download(url, index: index)
                }
            }
            
            while await group.next() != nil {
                if let (index, url) = iterator.next() {
                    group.addTask {
                        await self.download(url, index: index)
                    }
                }
            }
            
            
        }
    }
    
    
    
    private func download(_ url: URL, index:Int) async {
        do {
            let destination = localURL(for: url, index: index)
            if filemanager.fileExists(atPath: destination.path){
                print("Path: \(destination.path) already exists")
                return
            }
            print("URL:\(url.absoluteString)")
            let (data,_) = try await URLSession.shared.data(from: url)
            try data.write(to: destination)
            print("Saved: \(destination.lastPathComponent)")
        } catch {
            print("Failed: \(url) - \(error)")
        }
    }
    
    private func localURL(for url:URL, index:Int) -> URL {
        let filename = "\(index)_\(url.lastPathComponent)"
        let document = filemanager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return document.appendingPathComponent(filename)
    }
}




/*
 
 Great! That second part is the key to keeping a **constant number of concurrent downloads**. Let's walk through it with an example.

 Suppose you have:

 ```swift
 let urls = [A, B, C, D, E, F, G, H]
 ```

 and

 ```swift
 let maxConcurrentDownloads = 3
 ```

 ### Step 1: Initial `for` loop

 This starts the first 3 downloads:

 ```text
 Downloading:
 A
 B
 C
 ```

 The iterator is now pointing to **D**.

 ---

 ### Step 2: `group.next()`

 ```swift
 while await group.next() != nil {
 ```

 This line means:

 > "Wait until **one** of the currently running download tasks finishes."

 For example, suppose **B** finishes first.

 Now there are only two active downloads:

 ```text
 A ✅ Running
 B ❌ Finished
 C ✅ Running
 ```

 Since one slot is free, we start another download:

 ```swift
 if let (index, url) = iterator.next() {
     group.addTask {
         await self.download(url, index: index)
     }
 }
 ```

 The iterator returns **D**, so now:

 ```text
 A ✅ Running
 C ✅ Running
 D ✅ Running
 ```

 We're back to 3 concurrent downloads.

 ---

 ### Next iteration

 Suppose **A** finishes next.

 Again:

 ```swift
 await group.next()
 ```

 returns because a task finished.

 Iterator gives **E**.

 Now:

 ```text
 C ✅ Running
 D ✅ Running
 E ✅ Running
 ```

 ---

 ### This continues

 ```text
 C finishes → Start F
 D finishes → Start G
 E finishes → Start H
 ```

 Eventually the iterator has no more URLs.

 Then this part:

 ```swift
 if let (index, url) = iterator.next()
 ```

 returns `nil`, so no new tasks are added.

 The loop still waits for the remaining downloads to finish:

 ```text
 F finishes
 G finishes
 H finishes
 ```

 Finally:

 ```swift
 await group.next()
 ```

 returns `nil` because there are **no running tasks left**, so the `while` loop exits.

 ---

 ## Think of it like a queue at a supermarket

 You have **3 checkout counters**.

 Initially:

 ```
 Counter 1 → A
 Counter 2 → B
 Counter 3 → C
 ```

 When Counter 2 becomes free:

 ```
 Counter 1 → A
 Counter 2 → D
 Counter 3 → C
 ```

 When Counter 1 becomes free:

 ```
 Counter 1 → E
 Counter 2 → D
 Counter 3 → C
 ```

 There are **always 3 customers being served** until the queue is empty.

 ---

 ### Why not just start all downloads?

 If you have 10,000 images:

 ```swift
 for (index, url) in urls.enumerated() {
     group.addTask {
         await download(url, index: index)
     }
 }
 ```

 This creates **10,000 tasks immediately**, which wastes memory and scheduling overhead.

 The `while await group.next()` pattern ensures that:

 * Only `maxConcurrentDownloads` tasks are running at any given time.
 * As soon as one finishes, exactly one new task is started.
 * Memory usage stays low and download throughput remains steady.

 This is a common Swift concurrency pattern for implementing a **bounded task queue**.

 */
