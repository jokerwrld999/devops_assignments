# Getting Started
To test the application locally, follow these steps:

## Project Setup

1. Clone the repository
    ```bash
    git clone git@github.com:smenateam/assignments.git
    cd assignments/devops
    ```

2. Python3 interpreter is required.

3. Create a virtual environment and install dependencies
    ```bash
    pip install poetry
    poetry install
    ```

## Running the Server

1. Start the server
    ```bash
    poetry shell
    ./gunicorn.sh
    ```
