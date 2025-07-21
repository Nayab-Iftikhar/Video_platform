# Video Platform

This project is a video editing platform where clients can order customized video projects, select from various video types, and proceed to payment. The client logs in, views a list of their projects, and has the option to create new projects by selecting video types and entering footage details. The Project, VideoType, and User models are built with appropriate relationships, such as clients and project managers being assigned to projects, and video types being associated with projects. The form submission process is handled by form_with, where video types are selected using dynamic buttons, and the total price is calculated as items are added or removed from the cart. We integrated a payment modal that triggers when the user clicks the "Proceed to Payment" button, but the form is only submitted once the payment details are provided. We also utilized partials for reusable components like video type cards to keep the code organized and maintainable. Lastly, the background job for notifying the project manager was considered, and asynchronous tasks were planned but left for implementation to enhance scalability.

## Features

- User authentication (clients and project managers)
- Project management: assign clients, project managers, and upload footage
- Video type selection (Highlight Reel, Documentary Edit, Teaser, Social Media Clip)
- Video management per project
- Secure password handling (bcrypt)
- Authorization via Pundit policies
- Modern Rails 8 stack
- MySQL database support
- Bootstrap 5 styling

## Requirements

- **Ruby**: 3.3.1 (`.ruby-version`)
- **MySQL**: 5.6.4+
- **Bundler**: 2.4+

## Getting Started

### 1. Clone the repository

```bash
git clone <your-repo-url>
cd video_platform
```

### 2. Install dependencies

```bash
bundle install
```

### 3. Database setup

Edit `config/database.yml` if needed (defaults: user `root`, no password, socket `/tmp/mysql.sock`).

Create and prepare the database:

```bash
bin/rails db:prepare
```

### 4. Seed the database

```bash
bin/rails db:seed
```

This will create:
- 4 video types (Highlight Reel, Documentary Edit, Teaser, Social Media Clip)
- 3 project managers
- 3 clients
- 10 demo projects, each with 1-3 videos

### 5. Start the development server

```bash
rails server
```

This will run both the Rails server and CSS watcher (see `Procfile.dev`).

### 6. Access the app

Visit [http://localhost:3000](http://localhost:3000) in your browser.

## Running Tests

The project uses Minitest (Rails default):

```bash
bin/rails test
```

## Linting & Security

- Lint Ruby code: `bin/rubocop`
- Security scan (Ruby): `bin/brakeman`
- Security scan (JS): `bin/importmap audit`

## Technologies Used

- **Rails 8**
- **MySQL** (via `mysql2`)
- **Pundit** (authorization)
- **bcrypt** (passwords)
- **Turbo, Stimulus, Importmap, CSS Bundling**
- **Bootstrap 5** (via SCSS)
- **Solid Queue, Solid Cache, Solid Cable** (background jobs, caching, Action Cable)
- **Kamal** (deployment)
- **Brakeman, Rubocop, Capybara, Selenium** (dev/test tools)
