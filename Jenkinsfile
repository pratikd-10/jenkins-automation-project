pipeline {
    agent any
    
    // We removed the environment block for KUBECONFIG because we manually 
    // placed the config in the SystemProfile folder earlier. 
    // Jenkins will now find it automatically!

    stages {
        stage('Checkout') {
            steps {
                // Pulls your Node.js code from GitHub
                checkout scm
            }
        }
        
        stage('Build Image') {
            steps {
                // Changed 'sh' to 'bat' because Jenkins is on Windows
                // Using 'latest' for the kind load step consistency
                bat 'docker build -t pratik/my-app:latest .'
            }
        }

        stage('Sync to Kind') {
            steps {
                // NEW STEP: This moves the image from your Windows Docker engine 
                // into the internal storage of the 'kind' cluster nodes.
                bat 'kind load docker-image pratik/my-app:latest'
            }
        }

        stage('Deploy to K8s') {
            steps {
                // Applying your k8s folder manifests
                bat 'kubectl apply -f k8s/ --validate=false'
            }
        }
    }
}
