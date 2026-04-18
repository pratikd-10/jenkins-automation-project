pipeline {
    agent any
    
    environment {
        KUBECONFIG = "/var/lib/jenkins/.kube/config"
    }

    stages {
        stage('Checkout') {
            steps {
                // Jenkins automatically pulls the code from Git here
                checkout scm
            }
        }
        stage('Build Image') {
            steps {
                sh 'docker build -t pratik/my-app:${BUILD_NUMBER} .'
                sh 'docker tag pratik/my-app:${BUILD_NUMBER} pratik/my-app:latest'
            }
        }
        stage('Deploy to K8s') {
            steps {
                sh 'kubectl apply -f k8s/ --validate=false'
            }
        }
    }
}
