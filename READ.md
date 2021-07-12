Jessica Sylvester App Design Project
===

# MotoRent

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)


## Overview
### Description
Would operate as an online marketplace for short or long term car rentals.

Renters can:
Share their car on the platorfrm.
Update their listing and calendar availiabilty.
Message their rentee and manage their reservations.

Rentees can:
Book car rentals for their desired time period.
Search for different offerings.
Message their renter and manage thee reservation.


### App Evaluation

- **Category:** Car Rental / Travel
- **Mobile:** Website is view only, uses location services, map services, mobile first experience.
- **Story:** Allows users to share and rent out their cars/ rent a car.
- **Market:** Anyone that has a unused car to rent or is in need of a car. Would appeal to travellers in large group/with families to use over public transportation.
- **Habit:** N/A
- **Scope:** Would start out extremely narrow focused, just posting cars for rent. Could expand to other vehicles such as boats or motorcycles, see trending car, leave reviews of renters/rentees and see reviews.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can create a new account
* User can login
* User can post a listing for their car
* User can make a reservation for a car
  * Select location
  * Select Date
  * Select Info (price range, brand, size)
* User can see a list of their upcoming/current/previous reservations


**Optional Nice-to-have Stories**
* User can leave a review for a car/renter
* User can see reviews for a car/renter
* Settings (Accessibility, Notification, General, etc.)
* User can make a payment for reservation
* Users can message each other

### 2. Screen Archetypes

* Login Screen
   * User can login
* Registration Screen
   * User can create a new account
* Home Screen
   * User can start a reservation
   * User can view their reservations
* Reservation Screen
  * User can see their upcoming/current/previous reservations
* Profile Screen
  * User can create a listing for their vehicle



### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home - Start Reservation
* Reservations - Upcoming/Current/Past Reservations
* Account - Add a car to be rented


**Flow Navigation** (Screen to Screen)

* Login Screen
  * Home Screen
* Registration Screen
  * Home Screen
* Home Screen
  * Location Screen
  * Reservation Screen
* Location Screen
  * Date Screen
* Date
  * View Vehicles Screen
* View Vehicles Screen
  * Confirmation Screen
* Confirmation Screen
  * Reservation Screen

**Wireframes**
Link to Figma
https://www.figma.com/file/mRJo5bSrMdbovp7APpCfG5/FBU-App-Design?node-id=0%3A1

### 3. Schema

**Models**

Reservation

| Property| Type | Description |
| ------------- | ------------- |------------- |
|objectID  |String |unique id for the reservation (default field)  |
| rentee  | Pointer to User | person making the reservation  |
| locationID  | String | unique id for the reservation location  |
| startDate  | DateTime | date for the start of reservation |
| endDate  | DateTime | date for the end of reservation |
| vehicle  | Pointer to Vehicle | vehicle being rented  |

Vehicle

| Property| Type | Description |
| ------------- | ------------- |------------- |
|objectID  |String |unique id for the vehicle (default field)  |
| renter  | Pointer to User | person renting the vehicle  |
| type  | String | type of vehicle being rented  |
| startDate  | DateTime | date for the start of availiability |
| endDate  | DateTime | date for the end of availibility |
| price  | Number | price of vehicle being rented  |


**Networking**

* Confirm Reservation Screen
(Create/POST) Create a new reservation object

* Reservation Screen
(Read/GET) Query logged in reservation object

```
let query = PFQuery(className:"Reservation")
query.whereKey("author", equalTo: currentUser)
query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
   if let error = error {
      print(error.localizedDescription)
   } else if let reservations = reservations {
      print("Successfully retrieved \(reservations.count) reservations.")
  // TODO: Do something with reservations...
   }
}

```
(Update/PUT) Update reservation object

* Vehicle Registration Screen
(Create/POST) Create a new vehicle object

can take a photo, add a caption, and post it to "Instagram", pull to refresh
