# UI
- [x] Check out how to do Commands

## Screens
- [ ] Home Page

    ### When Logged In
    - [ ] Show bia history
    - [ ] Show Create Bia Button
    - [ ] Show BLE Connect Button || Status of connected

    ### When Logged Out
    - [ ] When has other users show users to choose from or create new user
    - [ ] When no other users redirect to CreateUser screen

- [ ] User Profile
    - [ ] Display User data
    - [ ] Display Edit User Button
    - [ ] Display Delete User Button
    - [ ] Have the ability to edit `User data in place


- [ ] Create Bia
    - [ ] Show steps the User must follow

- [ ] View Bia
    - [ ] Display Bia data alongside User data such as height

- [ ] View Bia History
    - [ ] Display a graph of User progress generated from the registered bias

# Data
- [ ] Implement BLE functionality

## Services
- [x] Implement stuff using Result

### Endpoints
- [x] GetCurrentUser()
- [x] GetUser(id)
- [x] DeleteUser(id)
- [x] UpdateUser(id)

- [ ] GetBia(id)
- [ ] CreateBia()
- [ ] GetBias()
- [ ] deleteBia(id)

## Repositories

### User Repository
- [ ] Model User data from Database to Domain and vice versa

### Bia Repository
- [ ] Model Bia data from Database to Domain and vice versa
- [?] Generate Graph data from Bias
