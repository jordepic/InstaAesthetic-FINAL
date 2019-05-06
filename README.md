InstaAesthetic
Enter a public Instagram account to recieve a comprehensive breakdown of its aesthetic!

LINKS: n/a

DESCRIPTION:
This app provides a color analysis of an instagram user's most recent posts.
After logging in, you enter a public instagram account name. The app then 
provides you the most frequent colors of the six most recent posts. Afterward, 
you can choose to save the account so you can quickly access it later.

IOS:
How my app meets the requirements:

AutoLayout using NSLayoutConstraint or SnapKit
-The app uses NSLayoutConstraint like in class, with UIViews defined in viewDidLoad and constraints defined in setUpConstraints

At least one UICollectionView or UITableView
-UITableView contains all the saved aesthetics. Two UICollectionViews are used to display the primary and secondary colors, with each CollectionViewCell essentially just being a circular UIView with a color.

Some form of navigation (UINavigationController or UITabBarController) to navigate between screens
-We use UINavigationController for the main ViewController and SavedViewController. We also modally present the login/register ViewControllers, and we also modally present the Aesthetic Breakdown ViewController.

Integration with an API - this API must provide some meaningful value to your app. For example, if you’re creating a music app, you could use the Apple Music API. Most of you will integrate with an API written by students in the backend course.
-The frontend uses only an API created by our backend members. This API is used to login, register an account, retrieve aesthetic information from accounts, and to store/delete saved accounts.

BACKEND:
Info about the requests is provided in the API Spec:
https://paper.dropbox.com/doc/Untitled--AcmQf3nHxMUM9ObMxKyE98IbAQ-eYs0woZYlYWFko088gMvE
We needed to change how the colors were returned to fit the IOS model
Uploaded to Google Cloud

OTHER INFO:
Small percentage of accounts do not return color data when requested. May have to do
with their settings.
We used the Google Vision API in order to return data about each
photo link, including each color and what Google deems it's "score".
If we had more time, we would have included the images themselves and
a more comprehensive analysis of the color data.

Screenshots:
![Screenshot 1](https://github.com/jordepic/InstaAesthetic-FINAL/blob/master/Screenshots/Screen%20Shot%202019-05-05%20at%208.44.20%20PM.png?raw=true)
![Screenshot 2](https://github.com/jordepic/InstaAesthetic-FINAL/blob/master/Screenshots/Screen%20Shot%202019-05-05%20at%208.44.42%20PM.png?raw=true)
![Screenshot 3](https://github.com/jordepic/InstaAesthetic-FINAL/blob/master/Screenshots/Screen%20Shot%202019-05-05%20at%208.45.18%20PM.png?raw=true)
![Screenshot 4](https://github.com/jordepic/InstaAesthetic-FINAL/blob/master/Screenshots/Screen%20Shot%202019-05-05%20at%208.45.35%20PM.png?raw=true)
![Screenshot 5](https://github.com/jordepic/InstaAesthetic-FINAL/blob/master/Screenshots/Screen%20Shot%202019-05-05%20at%208.46.06%20PM.png?raw=true)
![Screenshot 6](https://github.com/jordepic/InstaAesthetic-FINAL/blob/master/Screenshots/Screen%20Shot%202019-05-05%20at%208.46.52%20PM.png?raw=true)
![Screenshot 7](https://github.com/jordepic/InstaAesthetic-FINAL/blob/master/Screenshots/Screen%20Shot%202019-05-05%20at%208.47.05%20PM.png?raw=true)
