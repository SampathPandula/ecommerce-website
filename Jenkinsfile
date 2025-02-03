pipeline {
    agent any
    environment {
        AWS_KUBECONFIG = "/home/ubuntu/.kube/config"  // Specify the AWS kubeconfig
        KUBECONFIG = "/home/ubuntu/.kube/config"  // Ensure Jenkins uses the correct kubeconfig
    }
    stages {
        stage('Destroy IaC with Terraform') {
            steps {
                script {
                    // Change to the directory containing Terraform configuration files
                    dir('terraform') {
                        // Initialize Terraform
                        sh 'terraform init'

                        // Terraform plan to destroy the infrastructure
                        sh '''
                            terraform plan -destroy -out=tfplan || { echo "Terraform plan failed"; exit 1; }
                        '''
                        
                        // Apply the terraform destroy plan
                        sh '''
                            terraform apply tfplan || { echo "Terraform destroy failed"; exit 1; }
                        '''
                    }
                }
            }
        }
    }
}
