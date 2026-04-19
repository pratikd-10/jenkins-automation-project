pipeline {
    agent any

    environment {
        // This pulls the scanner tool you configured in Jenkins Global Tool Configuration
        SCANNER_HOME = tool 'SonarScanner'
        // This pulls the Snyk API token from your Jenkins Credentials
        SNYK_TOKEN = credentials('snyk-token')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/pratikd-10/jenkins-automation-project.git'
            }
        }

        stage('Static Code Analysis (SonarQube)') {
            steps {
                // Ensure 'SonarQube' matches the name in Manage Jenkins > System
                withSonarQubeEnv('SonarQube') {
                    bat "${SCANNER_HOME}/bin/sonar-scanner -Dsonar.projectKey=nodejs-k8s-app -Dsonar.sources=."
                }
            }
        }

        stage('Dependency Security Scan (Snyk)') {
    steps {
        // Use the full path to the .exe so there is no confusion
        bat "C:\\Windows\\System32\\snyk.exe test --token=${SNYK_TOKEN}"
    }
}

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t my-app:latest .'
            }
        }

        stage('Container Image Scan (Trivy)') {
            steps {
                // Running Trivy via Docker so you don't need to install anything extra
                // It scans for HIGH and CRITICAL vulnerabilities
                bat 'docker run --rm aquasec/trivy image --severity HIGH,CRITICAL my-app:latest'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                // 1. Load the new image into the Kind cluster
                bat 'kind load docker-image my-app:latest --name pratik-cluster'
                
                // 2. Apply your K8s manifests
                bat 'kubectl apply -f k8s/'
                
                // 3. FORCE RESTART: This ensures pods use the fresh image even if the tag is still :latest
                bat 'kubectl rollout restart deployment my-app'
                
                // 4. Wait for the rollout to finish so you know it's ready
                bat 'kubectl rollout status deployment my-app'
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution finished.'
        }
        success {
            echo 'App deployed successfully with Security Scans!'
        }
        failure {
            echo 'Pipeline failed. Check the logs for security vulnerabilities or build errors.'
        }
    }
}
