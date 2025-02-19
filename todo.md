# UI
- [x] Check out how to do Commands

## Screens
- [ ] Home Page

    ### When Logged In
    - [ ] Show bia history
    - [x] Show Create Bia Button
    - [x] Show BLE Connect Button || Status of connected

    ### When Logged Out
    - [x] When has other users show users to choose from or create new user
    - [x] When no other users redirect to CreateUser screen

- [ ] User Profile
    - [x] Display User data
    - [ ] Display Edit User Button
    - [ ] Display Delete User Button
    - [ ] Have the ability to edit User data in place


- [ ] Create Bia
    - [ ] Show steps the User must follow

- [ ] View Bia
    - [ ] Display Bia data alongside User data such as height

- [ ] View Bia History
    - [ ] Display a graph of User progress generated from the registered bias

# Data
- [x] Implement BLE functionality

## Services
- [x] Implement stuff using Result

### Endpoints
- [x] GetCurrentUser()
- [x] GetUser(id)
- [x] DeleteUser(id)
- [x] UpdateUser(id)

- [x] GetBia(id)
- [x] CreateBia()
- [x] GetBias()
- [x] deleteBia(id)

## Repositories

### User Repository
- [x] Model User data from Database to Domain and vice versa

### Bia Repository
- [x] Model Bia data from Database to Domain and vice versa
- [?] Generate Graph data from Bias
