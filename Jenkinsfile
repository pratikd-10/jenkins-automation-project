pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Pulls your Node.js code from GitHub
                checkout scm
            }
        }

        stage('Build Image') {
            steps {
                // Building the image locally on your Docker Desktop
                bat 'docker build -t my-app:latest .'
            }
        }

        stage('Deploy to Laptop') {
            steps {
                // 1. Remove the old container if it exists (prevents 'name already in use' error)
                // The '|| ver > nul' ensures the pipeline doesn't fail if the container isn't found
                bat 'docker rm -f my-app || ver > nul'

                // 2. Start the container on your laptop's port 3000
                // -d runs it in the background
                // -p 3000:3000 maps your laptop port to the container port
                bat 'docker run -d -p 3000:3000 --name my-app my-app:latest'
                
                echo 'Application is live! Visit http://localhost:3000'
            }
        }
    }
}
