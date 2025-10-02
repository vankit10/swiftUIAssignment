# swiftUIAssignment
This is a SwiftUI app that fetches posts from a remote API and provides functionality to view, search, and manage favorite posts. The app is built using the MVVM architecture to separate concerns and ensure maintainability. Users can browse all posts, search through them in real-time, view detailed information, and manage favorites easily.
Features
# 1. Fetch Posts

Retrieves posts asynchronously from the API endpoint:
https://jsonplaceholder.typicode.com/posts

Each post contains:

userId (Int)

id (Int)

title (String)

body (String)

# 2. List Screen

Displays all posts in a scrollable list.

Shows the post title and user ID on each row.

Provides a heart icon to mark/unmark posts as favorites.

# 3. Search Functionality

Includes a search bar at the top of the list.

Filters posts in real-time based on the title.

# 4. Detail Screen

Navigates to a detailed view when a post is selected.

Displays the post title prominently and the post body text.

Allows toggling favorites from the detail screen.

# 5. Favorites Tab

Contains a dedicated tab for viewing favorite posts.

Shows all posts marked as favorites.

Displays the same information as the main list.

# 6. Architecture

Follows the MVVM (Model-View-ViewModel) pattern.

Networking code is isolated from the Views.

Uses @StateObject and @AppStorage for state management and persistence.

# Bonus Features (Optional)

Shows a loading indicator (SVProgressHUD) while fetching posts.

Handles error states with user-friendly alerts.

Implements pull-to-refresh functionality to reload posts.

# Technologies & Tools Used

Swift 5+

SwiftUI

Combine (or async/await)

URLSession for network requests

@AppStorage for local data persistence

MVVM architectural pattern

SVProgressHUD for loading indicator

# How to Run

Clone the repository.

Open the project in Xcode.

Build and run the app on a simulator or physical device running iOS 15+.

Explore posts, search, toggle favorites, and switch between tabs.

# Folder Structure

Model: Contains data structures representing posts.

ViewModel: Manages API calls, business logic, and state.

View: SwiftUI views including list, detail, favorites, and tab views.

Networking: Contains APIManager for network requests.

# Author

Created by Ankit Verma
