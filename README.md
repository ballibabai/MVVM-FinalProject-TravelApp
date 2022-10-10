# FinalProject

    Travel App
    
#### App Description
- Application has three ViewController in tabbar
- First field is HomeVC. used collectionView here. this VC has two buttons(Flight and Hotel) and has collectionview for the **ArticleData** bottom the page
  - CollectionView has **BookmarkButton** if it's clicked save to **CoreData** and added **BookmarkVC**
  - If click collectionView cell, goes to BookmarkVC
  - Same scenario applies to **flight** and **hotel** buttons, if click goes to **ListVC**
- Second field is SearchVC made with tableView. There is a **TextField** for search :) and has two button for **flight** and **hotel**
  - lists flights but does not show until condition is met when click flight button, same scenario applies for the hotel
  - if click a cell, goes to DetailVC
- Third field is BookmarkVC made with tableView. default is empty but if save a data can see in here
  - if click a cell, goes to DetailVC
- DetailVC has imageView, textView and a button
  - Button is goal for save to core data and delete from core data
- All data is mockData but there is a Api data from https://app.goflightlabs.com for the Flight
- If you have problems about **Kingfisher** and **Alamofire** after download zip or clone, you should do fetch or again add Kingfisher and Alamofire in Xcode (Kingfisher and Alamofire installed in app with SPM)

#### Tools I use
- UIKit
- NavigationController
- TabBarController
- TableView
- CollectionView
- Auto Layout
- OOP
- URLSession
- CoreData

#### Third Party Library
- KingFisher
- Alamofire

#### Software Architectural Pattern
- MVVM


#### Photos

<img src = "https://user-images.githubusercontent.com/103687289/194965857-741af0af-3455-488a-a799-484730fc7e83.png" width="200" hight="200" /><<img src = "https://user-images.githubusercontent.com/103687289/194965707-82687ea8-085b-4f8d-9dd9-c297629ffb9f.png" width="200" hight="200" /><img src = "https://user-images.githubusercontent.com/103687289/194965261-3dff61d7-78b1-4e85-a0d3-3663f6e0f2fc.png" width="200" hight="200" /><img src = "https://user-images.githubusercontent.com/103687289/194965482-aa8f7b81-e414-4301-b245-d933485d70db.png" width="200" hight="200" /><img src = "https://user-images.githubusercontent.com/103687289/194965540-d1e1c730-efb3-4751-864e-1301c772e777.png" width="200" hight="200" /><img src = "https://user-images.githubusercontent.com/103687289/194965599-dba8ceb6-78e4-4aa2-9df9-69e11b3c8d48.png" width="200" hight="200" />




