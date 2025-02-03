pipeline {
    agent any
    environment {
        ECR_REPO = "713881815267.dkr.ecr.us-east-1.amazonaws.com/ecommerce-repo"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/SampathPandula/ecommerce-website.git'

            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $ECR_REPO:latest .'
            }
        }
        stage('Push to ECR') {
            steps {
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_REPO'
                sh 'docker push $ECR_REPO:latest'
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yaml'
            }
        }
    }
}
