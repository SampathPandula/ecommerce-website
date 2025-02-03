pipeline {
    agent any
    environment {
        ECR_REPO = "713881815267.dkr.ecr.us-east-1.amazonaws.com/ecommerce-website"
        AWS_KUBECONFIG = "/home/ubuntu/.kube/config"  // Specify the AWS kubeconfig
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

                // Debug: Show the contents of the deployment.yaml file
                sh 'cat k8s/deployment.yaml'

                // Verify if Kubernetes cluster is accessible
                sh '''
                    echo "Verifying Kubernetes connection"
                    aws eks --region us-east-1 update-kubeconfig --name ecommerce-cluster # Update with your EKS cluster name
                    kubectl cluster-info || { echo "Kubernetes connection failed"; exit 1; }
                '''

                // Apply the Kubernetes deployment
                sh '''
                    echo "Applying Kubernetes deployment"
                    kubectl apply -f k8s/deployment.yaml --validate=false || { echo "Kubernetes deployment failed"; exit 1; }
                '''
            }
        }
    }
}
