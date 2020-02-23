import UIKit

class Movie: NSObject, NSCoding {
    var title: String
    var viewedDate: Date
    var theatre: String
    var rating: Int?{
        didSet{
            if rating! > 10 || rating! < 1 {
                rating = nil
            }
        }
    }
    
    init(title: String, theatre: String, rating: Int?) {
        self.title = title
        self.theatre = theatre
        self.rating = rating
        self.viewedDate = Date()
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(theatre, forKey: "theatre")
        aCoder.encode(rating, forKey: "rating")
        aCoder.encode(viewedDate, forKey: "viewedDate")
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as! String
        theatre = aDecoder.decodeObject(forKey: "theatre") as! String
        rating = aDecoder.decodeObject(forKey: "rating") as? Int
        viewedDate = aDecoder.decodeObject(forKey: "viewedDate") as! Date
        
        super.init()
    }
}
