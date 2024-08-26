# Blog Application

## Overview

The Blog Application is a RESTful API designed to manage user authentication and blog posts. The application allows users to sign up, log in, create, read, update, and delete posts, and manage comments. Each post and comment is associated with an authenticated user, and posts are automatically deleted after 24 hours. 

## Technologies Used

- **Ruby on Rails**: Framework for building the RESTful API.
- **PostgreSQL**: Relational database management system for storing data.
- **Sidekiq**: Background job processing for scheduling post deletions.
- **Redis**: In-memory data structure store used by Sidekiq.
- **Docker**: Containerization platform to simplify setup and deployment.

## Features

### User Authentication
- **Endpoints**:
  - `POST /users` - Register a new user.
  - `POST /users/sign_in` - Authenticate a user and obtain a JWT token.
  - `DELETE /users/sign_out` - Sign out a user.
- **User Model Fields**:
  - `name` - User’s name.
  - `email` - User’s email address.
  - `password` - User’s password.
  - `image` - User’s profile image URL.

### Posts
- **Endpoints**:
  - `POST /posts` - Create a new post.
  - `GET /posts` - List all posts.
  - `GET /posts/:id` - Retrieve a specific post.
  - `PUT /posts/:id` - Update an existing post only if the user is the author.
  - `DELETE /posts/:id` - Delete a post only if the user is the author.
- **Post Model Fields**:
  - `title` - Title of the post.
  - `body` - Content of the post.
  - `author` - User ID of the post’s author.
  - `tags` - List of tags associated with the post.
  - `comments` - List of comments on the post.

### Comments
- **Endpoints**:
  - `POST /posts/:post_id/comments` - Add a comment to a post.
  - `PUT /comments/:id` - Update a comment only if the user is the author.
  - `DELETE /comments/:id` - Delete a comment only if the user is the author.
- **Comment Model Fields**:
  - `body` - Content of the comment.
  - `user` - User ID of the comment’s.
  - `post` - Post ID of the comment’s parent post.

### Data Constraints
- Each post must have at least one tag.
- Users/authors can only edit or delete their own posts and comments.
- All posts are automatically deleted 24 hours after creation.

## Setup

### Prerequisites

- [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) installed on your machine.

### Running the Application

1. **Clone the repository**:

   ```bash
   git clone https://github.com/moeyad7/rails-blog-api.git
   cd rails-blog-api
   ```

2. **Start the application using Docker Compose**:

   ```bash
   docker-compose up
   ```

   This command will build and start the Docker containers for the application, database, and Redis.

3. **Access the application**:
   - The API will be available at `http://localhost:3000`.

## Additional Notes

- **JWT Authentication**: Ensure that you include the JWT token in the `Authorization` header for endpoints requiring authentication.
- **Post Deletion**: Posts are scheduled for deletion 24 hours after creation using Sidekiq jobs.