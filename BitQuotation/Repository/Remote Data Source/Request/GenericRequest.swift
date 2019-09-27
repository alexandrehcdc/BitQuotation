import Foundation

struct GenericRequest {
    
    static func simpleGetWith<T>(url: URL, _ responseCallback: @escaping ((T) -> Void)) where T: Codable {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let retrievedData = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: retrievedData)
                
                responseCallback(decodedData)
            } catch let error {
                // fix here <- learn first about blockchain api errors
                print(error)
            }
        }.resume()
    }
    
}
