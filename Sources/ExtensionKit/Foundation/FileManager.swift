import Foundation

public extension FileManager {
    
    /// Size of file at path
    ///
    /// - Parameter path: file path
    /// - Returns: Size in bytes
    func fileSize(atPath path: String) -> Int {
        let attributes = try? attributesOfItem(atPath: path)
        return (attributes?[FileAttributeKey.size] as? Int) ?? 0
    }
    
    /// Size of folder
    ///
    /// - Parameter path: folder path
    /// - Returns: size in bytes
    func folderSize(atPath path: String) -> Int {
        let manager = FileManager.default
        if manager.fileExists(atPath: path) {
            do {
                let childFilesEnumerator = try (manager.subpathsOfDirectory(atPath: path) as NSArray).objectEnumerator()
                var folderSize = 0
                while childFilesEnumerator.nextObject() != nil {
                    if let fileName = childFilesEnumerator.nextObject() as? String,
                        let url = URL(string: path) {
                        let fileAbsolutePath = url.appendingPathComponent(fileName).absoluteString
                        folderSize += self.fileSize(atPath: fileAbsolutePath)
                    }
                }
                return folderSize
                
            } catch {
                dprint(error)
            }
        }
        return 0
    }
    
    
    /// Size of directory at URL
    ///
    /// - Parameter URL: URL
    /// - Returns: Size in bytes
    func directorySize(at URL: URL) -> Int {
        var result = 0
        let properties = [URLResourceKey.localizedNameKey, URLResourceKey.creationDateKey, URLResourceKey.localizedTypeDescriptionKey]
        let manager = FileManager.default
        do {
            let urls = try manager.contentsOfDirectory(at: URL, includingPropertiesForKeys: properties, options: .skipsHiddenFiles)
            for fileSystemItem in urls {
                var directory: ObjCBool = false
                let path = fileSystemItem.path
                manager.fileExists(atPath: path, isDirectory: &directory)
                if directory.boolValue {
                    result += directorySize(at: fileSystemItem)
                } else {
                    result += try manager.attributesOfItem(atPath: path)[FileAttributeKey.size] as! Int
                }
            }
            
        } catch {
            dprint("Error: \(error)")
        }
        return result
    }
}
