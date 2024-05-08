//
//  LocalFileManager.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/8/24.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let shared = LocalFileManager()
    
    private init() { }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        createFolderIfNeeded(folderName: folderName)
        
        guard 
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName.replacingOccurrences(of: "/", with: ""), folderName: folderName)
        else { return }

        do {
            try data.write(to: url)
        } catch let error {
            print("Error: \(error) saving an image. Image Name: \(imageName)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> Image? {
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path(percentEncoded: true)) else {
            
            return nil
        }
        
        if let uiImage = UIImage(contentsOfFile: url.path(percentEncoded: true)) {
            
            return Image(uiImage: uiImage)
        }
        
        return nil
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path(percentEncoded: true)) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("Error: \(error) creating a local cache directory. FolderName: \(folderName).")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else { return nil }
        
        return folderURL.appendingPathComponent(imageName)
    }
}
