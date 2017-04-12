import UIKit
import Dispatch

typealias ImageClosure = (UIImage) -> ()

class ImageDownloadOperation: Operation {
    
    private let completion: ImageClosure
    private let imageURL: String
    
    init(with imageURL: String, completion: @escaping ImageClosure) {
        self.completion = completion
        self.imageURL = imageURL
    }
    
    override func start() {
        if isCancelled {
            return
        }
        
        //---------------------< imageDownload >
        
        let url:URL = URL(string: imageURL)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.completion(UIImage(data : data!)!)
            }
        })
        task.resume()

        
        //-------------------------<>
        
        if isCancelled {
            return
        }
    }
}

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    
    private let imageDownloadQueue = OperationQueue()
    
    override func awakeFromNib() {
        imageDownloadQueue.name = "Image download queue"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageDownloadQueue.cancelAllOperations()
    }
    
    func setup(with rowIndex: Int, band : Band) {
        self.mainLabel?.text = band.name
        self.label?.text = band.countryOfOrigin
        
        if let imageURL = band.logoURL {
            let downloadOperation = imageDownloadOperation(with: imageURL) { [weak self] result in
            self?.newImageView?.image = result
            self?.setNeedsLayout()
        }
            imageDownloadQueue.addOperation(downloadOperation)
        }
    }
    
    private func imageDownloadOperation(with imageURL: String, completion: @escaping ImageClosure) -> Operation {
        let operation = ImageDownloadOperation(with: imageURL, completion: completion)
        return operation
    }
}
