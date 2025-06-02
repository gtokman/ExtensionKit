import Photos

public extension PHAsset {
    /// Retrieve the filename of a photo from the photos library using information from `PHAsset`
    /// 
    var originalFilename: String? {
        var fileName: String?
        
        if #available(iOS 9.0, *) {
            let resources = PHAssetResource.assetResources(for: self)
            if let resource = resources.first {
                fileName = resource.originalFilename
            }
        }
        
        if fileName == nil {
            /// This is an undocumented workaround that works as of iOS 9.1
            fileName = self.value(forKey: "filename") as? String
        }
        
        return fileName
    }
}
