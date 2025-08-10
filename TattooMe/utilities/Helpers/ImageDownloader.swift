//
//  DownloadImage.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 09/07/2025.
//


#if os(iOS)

import UIKit
import Photos

class ImageDownloader{
  static func downloadImage(urlString: String, completion: @escaping(Result<UIImage, Error>) -> Void){
      guard let url = URL(string: urlString) else{
          print("Error, invalid url")
          completion(.failure(ImageDownloadError.invalidURL))
          return
      }
      
      URLSession.shared.dataTask(with: url) { data, response, error in
                  // Handle network errors
                  if let error = error {
                      DispatchQueue.main.async {
                          completion(.failure(error))
                      }
                      return
                  }
                  
                  // Validate response data
                  guard let data = data else {
                      DispatchQueue.main.async {
                          completion(.failure(ImageDownloadError.noData))
                      }
                      return
                  }
                  
                  // Create image from data
                  guard let image = UIImage(data: data) else {
                      DispatchQueue.main.async {
                          completion(.failure(ImageDownloadError.invalidImageData))
                      }
                      return
                  }
           
                  DispatchQueue.main.async {
                      completion(.success(image))
                  }
              }.resume()
    }
    
    enum ImageDownloadError: Error, LocalizedError {
          case invalidURL
          case noData
          case invalidImageData
          
          var errorDescription: String? {
              switch self {
              case .invalidURL:
                  return "The provided URL is invalid"
              case .noData:
                  return "No image data was received"
              case .invalidImageData:
                  return "The received data couldn't be converted to an image"
              }
          }
      }
}

#endif
