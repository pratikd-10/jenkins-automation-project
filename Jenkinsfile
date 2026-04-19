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
        bat 'docker build -t my-app:latest .'
    }
}
stage('Sync to Kind') {
    steps {
        bat 'kind load docker-image my-app:latest --name pratik-cluster'
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
