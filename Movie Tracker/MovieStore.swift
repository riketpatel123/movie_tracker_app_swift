import UIKit

class MovieStore{
    var movies = [Movie]()
    // add new movies to list
    @discardableResult func createMovie() -> Movie {
        let newMovie = Movie(title: "", theatre: "", rating: nil)
        movies.append(newMovie)
        return newMovie
    }
    // Remove movies from list
    func removeMovie(_ movie: Movie) {
        if let index = movies.index(of: movie){
            movies.remove(at: index)
        }
    }
    // Move the the movies
    func moveMovie(from fromIndex: Int, to toIndex: Int){
        if fromIndex == toIndex{
            return
        }
        let movedItem = movies[fromIndex]
        movies.remove(at: fromIndex)
        movies.insert(movedItem, at: toIndex)
    }
    // ArchiveURL property to determine the location of the movies.archive file
    let movieArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("movies.archive")
    }()
    // Initializer will attempt to unarchive the movie data.
    init() {
        if let data = try? Data(contentsOf: movieArchiveURL) {
            let archivedItems = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Movie]
            movies = archivedItems!
        }
    }
    //Save all Movies data into archive
    func save() -> Bool {
        print("Saving items to : \(movieArchiveURL.path)")
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: movies, requiringSecureCoding: false)
            try data.write(to: movieArchiveURL)
            return true
        } catch let saveError {
            print("Error attempting to save items: \(saveError)")
            return false
        }
    }
    
}
