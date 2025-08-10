//
//  SaveImage.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 09/07/2025.
//

#if os(iOS)

import UIKit
import Photos
class ImageHelper{
    
    static func saveImageToGallery(_ image: UIImage, completion: @escaping (Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized || status == .limited {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                DispatchQueue.main.async{
                    completion(true)
                }
            } else {
                DispatchQueue.main.async{
                    completion(false)
                }
            }
        }
    }
    
    static func saveImageToLocalDirectory(image: UIImage, fileName: String, completion: (String, Bool)->Void) throws {
        guard let imageData = image.jpegData(compressionQuality: 0.9) else {
            completion(fileName, false)
            throw NSError(domain: "ImageConversion", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])
        }
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let fileURL = documentsURL.appendingPathComponent("\(fileName).jpg")
        
        if !FileManager.default.fileExists(atPath: fileURL.path) {
             print("⚠️ File name: \(fileURL.path): \(fileName)")
            
               try imageData.write(to: fileURL)
               completion(fileName, true)
           } else {
               print("⚠️ File already exists: \(fileURL.path)")
               completion(fileName, true)
           }
    }
    
    static func deleteURIFromDocuments(urlImage: URL) throws {
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: urlImage.path) {
            try fileManager.removeItem(at: urlImage)
            print("✅ Deleted image at: \(urlImage.path)")
        } else {
            print("⚠️ File does not exist at path: \(urlImage.path)")
        }
    }
    
    
    static func convertUrlToUIImage(url: URL)->UIImage?{
        return UIImage(contentsOfFile: url.path)
    }
    
    static func getAllImageURLsFromDocuments() -> [URL] {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!

        do {
            let fileURLs = try fileManager.contentsOfDirectory(
                at: documentsURL,
                includingPropertiesForKeys: [.creationDateKey],
                options: [.skipsHiddenFiles]
            )

            let imageURLs = fileURLs.filter {
                ["jpg", "png"].contains($0.pathExtension.lowercased())
            }

            let sortedImageURLs = imageURLs.sorted { url1, url2 in
                let date1 = (try? url1.resourceValues(forKeys: [.creationDateKey]).creationDate) ?? Date.distantPast
                let date2 = (try? url2.resourceValues(forKeys: [.creationDateKey]).creationDate) ?? Date.distantPast
                return date1 > date2 // Newest first
            }

            return sortedImageURLs
        } catch {
            print("Error reading contents of documents folder: \(error)")
            return []
        }
    }

    
    static func convertImageToURL(named name: String, withExtension ext: String = "png") -> URL? {
        guard let image = UIImage(named: name) else {
            print("Image named '\(name)' not found.")
            return nil
        }

        guard let data = (ext.lowercased() == "jpg" || ext.lowercased() == "jpeg")
            ? image.jpegData(compressionQuality: 1.0)
            : image.pngData() else {
            print("Failed to convert image to \(ext.uppercased()) data.")
            return nil
        }

        let tempDirectory = FileManager.default.temporaryDirectory
        let fileURL = tempDirectory.appendingPathComponent("\(UUID().uuidString).\(ext)")

        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("Error writing image to disk: \(error)")
            return nil
        }
    }

}

#endif
