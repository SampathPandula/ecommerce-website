pipeline {
    agent any
    environment {
        ECR_REPO = "713881815267.dkr.ecr.us-east-1.amazonaws.com/ecommerce-website"
        KUBECONFIG = "/home/ubuntu/.kube/config"  // Ensure Jenkins uses the correct kubeconfig
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/SampathPandula/ecommerce-website.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t 713881815267.dkr.ecr.us-east-1.amazonaws.com/ecommerce-website:latest .'
            }
        }
        stage('Push to ECR') {
            steps {
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 713881815267.dkr.ecr.us-east-1.amazonaws.com/ecommerce-website'
                sh 'docker push 713881815267.dkr.ecr.us-east-1.amazonaws.com/ecommerce-website:latest'
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                // Debug: Verify that the k8s directory and deployment.yaml file exists
                sh 'ls -l k8s/'
                sh 'cat k8s/deployment.yaml'
                
                // Apply the Kubernetes deployment
                sh 'kubectl apply -f k8s/deployment.yaml --validate=false'
            }
        }
    }
}
