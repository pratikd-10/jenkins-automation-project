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
        // We add the --name flag to match the cluster we just created
        bat 'kind load docker-image pratik/my-app:latest --name pratik-cluster'
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
