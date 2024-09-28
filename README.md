# README
## Contact Manager
This is a simple Contact Manager application built with Ruby on Rails. It allows users to add, view, edit, delete, and search contacts. Contacts are displayed in a sortable and paginated table with basic form validations and error handling.

### Features
* **Manage Contacts (CRUD)**: Create, Read, Update and Delete contacts with name, phone number, email address and image.
* **Search Contacts**: Search for contacts by name, phone number or email.
* **Pagination**: Display 10 contacts per page.
* **Validations**: Includes validation for name, phone and email fields.
* **Flash Messages**: Displays success and error messages for actions.
* **Sorting**: Sort contacts by name, phone number or email in ascending or descending order using clickable column headers.

### Project Prerequisites
To run this project locally, ensure you have the following installed:

* ```Ruby Version: 3.0.2```
* ```Rails Version: 7.0.8```
* ```Database: PostgreSQL```

### Setup Instructions
There are two ways to set up and run the application: manually or using Docker.

#### Manual Setup
1. Clone the repository and navigate to project directory:

    > git clone https://github.com/himalayan-sanjeev/contact-manager

    > cd contact_manager

2. Install dependencies: Run the following command to install the necessary gems:

    > bundle install

3. Setup the database: Create the database and run the migrations:
    > rails db:create
    
    > rails db:migrate

4. Start the Rails server: Run the following command to start the server:
    > rails server

    Access the application: Visit http://localhost:3000 in your browser to access the app.

    #### Running Tests
    This project uses RSpec for unit tests and FactoryBot for generating test data. To execute the test suite, run the following command:

      > bundle exec rspec

#### Docker Setup
1. Build the Docker images:

    > docker-compose build

2. Run the containers:
    Start the application using Docker Compose:

    > docker-compose up

    This will start the Rails app and PostgreSQL database. The Rails app will be available at http://localhost:3001

3. Setup the database: Create the database and run the migrations:
    > docker-compose exec web bin/rails db:create
    
    > docker-compose exec web bin/rails db:migrate

4. Running Tests:
    > docker-compose exec web bundle exec rspec

    This runs the test suite inside the Docker container.
    
5. Accessing the Rails Console:
   > docker-compose exec web bin/rails console

6. Stopping the containers:
   > docker-compose down

### Future Improvements
As this is the basic requirement for now, the project includes basic implementations of the requested features. However, it can be enhanced further with more customization and efficiency by utilizing various approaches and gems:
* Add API Support to enable integration with frontend frameworks or mobile apps.
* Implement Authentication and Authorization using gems like Devise and Pundit for secure access control.
* Use gem like Kaminari for efficient and customizable pagination.
* Integrate gem like Filterrific for advanced filtering and sorting functionality, enhancing the user experience with flexible and efficient query options.
