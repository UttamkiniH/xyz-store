## Description:-
An e-commerce app built using Flutter and Firebase would be a mobile application that allows users to browse and check out products from a virtual storefront; It would use Flutter, a cross-platform mobile development framework, to build the user interface and handle the app’s functionality.
These are the number of features that I implemented in my e-commerce app using Flutter and Firebase.
### Product Catalog Page:
Using Firebase's Cloud FireStore, to store information about products, such as images, descriptions, sizes, and prices.
I have used flutter ListViewBuilder to showcase the different products.
Created hero animations to animate the images whenever the user clicks on the product.
Added pageView widget to swipe between the different images of the product. These images are stored in firebase storage and fetched from Firebase FireStore.
Search Products Page:
User can search for different products in the search page. These product data are fetched from Firebase fireStore where we used Where clause (is greater than or equal to) query to filter the search.
### Shopping cart Page:
I used Firebase's Cloud FireStore (user collection) to store information about the products that users have added to their shopping carts.
Users can increase or decrease the number of quantities of a particular product using provider instance.
To calculate total price I did using number of quantities * product price to calculate the total price and displayed it to the user.
### Checkout Page:
After the user confirms with the products, he/she will be taken to fetch Location page where the user is requested to give permission for the location.
I used flutter geolocator and geocoding to fetch the location of the user and convert them to String type readable address.
### Confirmation Page:
User can check the items ordered along with the order details such as order_id, order_date, address and number of items that has been purchased.
I used expansion tile in flutter to display the ordered items.
With the help off uuid(v4) package generated random id for the order_id
### Settings Page:
In this page user can switch theme from dark mode to light mode, choose different language (English, Hindi, and Kannada) for the app, and Log out feature to log out from the app
For the dark theme toggle I used provider to call the provider instance and change the app theme by using ThemeData.
To choose language I used easy_localization package and defined keywords such as appName, checkout, Order in selected locale languages.
### User accounts:
Firebase's Authentication service to allow users to create accounts and log in to the app. User can also choose sing-in with Google instead of sing-up and login.
I used firebase_auth package to get the firebase auth instance and call the different methods such as signInWithEmailAndPassword, signInWithCredential and singOut
Used flutter validator methods to validate the user before login and signup
### State Management and Navigation:
I used provider package to manage the state of different features such as theme, fetching the products, adding the product to cart, increasing or decreasing the quantity, and deleting the cart products.
For Navigation of the app I used go_router package and specified different routes and subroutes for the app.
### Other features:
Added lottie animation package to show icon animations.
Hero animation for the product images when the user interacts.
Implemented Loading screen using Scale Animation in flutter.