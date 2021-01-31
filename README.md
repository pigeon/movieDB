# MovieDB
# About the app

The application uses The Movie database API to get the list of popular movies [GET /movie/popular](https://developers.themoviedb.org/3/movies/get-popular-movies) and then show details of the selected movie [GET
/movie/{movie_id}](https://developers.themoviedb.org/3/movies/get-movie-details). There is only a budget amount (if available) that is taken from the movie details API but it can be extended to present pretty much anything since the data is returned by API. The app has very simple UI just enough to present to the user info about popular movies and some details and also notify about an error that happened.

# Dependencies

There is a library for downloading and caching images [Kingfisher](https://github.com/onevcat/Kingfisher) and [EasyStash](https://github.com/onmyway133/EasyStash) for caching responses that I used in the task. I also used [Sourcery](https://github.com/krzysztofzablocki/Sourcery) for mock generation and [quicktype](https://app.quicktype.io/) for codable objects generation

# Architecture

The app is built using MVVM architecture with additional layers such as Router, Service and Repository. 
`Router` is an abstraction that is responsible for user journey and navigation between view controller.
`Service` is the layer that works with Movie database API.  
`Repository` is a layer that responsible for delivering data from the service to the view.

                        +-------------+
                        |             |
                        |   Service   |
                        |             |
                        |             |
                        +------+------+
                               ^
                        +------+------+
                        |             |
                        |             +<-------------+
                        | Repository  |              |
                        |             |              |
                        +-------------+              |
                    +--------------------------------------------------------+
                    |                                                        |
                    |      +------+-------+       +-----+-------+            |
                    |      |              |       |             |            |
                    |      | ViewModel    |       | ViewModel   |            |
                    |      |              |       |             |            |
                    |      +-------+------+       +------+------+      +-----+-----+
                    |              ^                     ^             |           |
                    |              |                     |             |   Router  |
                    |              |                     |             |           |
                    |      +-------+--------+     +------+---------+   +-----------+
                    |      |                |     |                |         |
                    |      | ViewController |     | ViewController |         |
                    |      |                |     |                |         |
                    |      +----------------+     +----------------+         |
                    |                                                        |
                    +--------------------------------------------------------+

# Tests

Service, Repository and ViewModel layers are covered with unit tests. Standard `XCTest` framework is used for this purpose. `XCUITest` framework would work well for testing views and interaction

# What could be improved

- UI is really basic 
- A lot of information that is available is not present
- Navigation controller could be abstracted in the `Router` and it would make Route testing possible 
- Acceptance testing is missing
- Details view is static and would either need to be wrapped into scroll view or table/collection view to present more information
- There is [GET /configuration](https://developers.themoviedb.org/3/configuration/get-api-configuration) that should be used for images base URLs
- The app would benefit from pull to refresh function to get the list of the latest popular movies
